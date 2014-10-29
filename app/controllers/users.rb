get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.new(:email => params[:email],
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

get'/users/password-reminder' do
	erb :"users/password_reminder"
end

post'/users/password-reminder' do
	user = User.first(:email => email)
	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	user.password_token_timestamp = Time.now
	user.save
end

get '/users/reset_password/:token' do
	user = User.first(:password_token => token)
	if user.password_token_timestamp <= (Time.now + 60)
		erb :"users/password_reset"
	end
end

post 'users/password-reset' do

end

