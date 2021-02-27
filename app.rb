require 'sinatra/base'
require './get_connection.rb'
require 'sinatra/flash'
require 'date'

class Chitter < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  before do
    @result = DBConnection.query("SELECT * FROM peeps ORDER BY date DESC, time DESC;")
  end

    get '/' do
      redirect('/peeps')
    end

    get '/peeps' do
      erb(:'peeps/index')
    end

    get '/users/new' do
      erb(:'users/new')
    end

    post '/users/new' do
      @email = params[:email]
      @password = params[:password]
      @name = params[:name]
      @username = params[:username]
      user = DBConnection.query("INSERT INTO users (email, password, name, username) VALUES('#{@email}', '#{@password}', '#{@name}', '#{@username}') RETURNING id, email, password, name, username;")
      flash[:signup_success] = "Welcome to Chitter, #{user[0]['name']}!"
      redirect('/')
    end

    get '/peeps/new' do
      erb(:'peeps/new')
    end

    post '/peeps/new' do
      @content = params[:content]
      time = DateTime.now
      @date = time.strftime("%Y-%m-%d")
      @time = time.strftime("%H:%M")
      DBConnection.query("INSERT INTO peeps (content, date, time) VALUES('#{@content}', '#{@date}', '#{@time}');")
      redirect('/')
    end

    run! if app_file == $0
end
