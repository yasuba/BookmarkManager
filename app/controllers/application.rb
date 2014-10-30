	get '/' do
		@links = Link.all
    @texts = []
		erb :index
	end
