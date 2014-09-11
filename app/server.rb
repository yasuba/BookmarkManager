require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

	enable :sessions
	set :session_secret, 'super secret'
	use Rack::Flash

	helpers do

		def current_user
			@current_user ||=User.get(session[:user_id])if session[:user_id]
		end

	end
	get '/' do
		@links = Link.all
		erb :index
	end

	post '/links' do
		url = params['url']
		title = params['title']
		tags = params["tags"].split(" ").map do |tag|
			Tag.first_or_create(:text => tag)
		end
		Link.create(:url => url, :title => title, :tags => tags)
		redirect to ('/')
	end

	get '/tags/:text' do
		tag = Tag.first(:text => params[:text])
		@links = tag ? tag.links : []
		erb :index
	end

	get '/users/new' do
		@user = User.new
		erb :"users/new"
	end

	post '/users' do
		@user = User.create(:email => params[:email],
					:password => params[:password],
					:password_confirmation => params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect to('/')
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :"users/new"
		end
	end
end