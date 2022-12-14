require "sinatra/base"
require "sinatra/reloader"
require_relative "./lib/database_connection"
require_relative "./lib/user_repository"

DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    @status = session[:user_id]
    @name = session[:user_name]
    puts session
    return erb(:home_page)
  end

  post "/" do
    repo = UserRepository.new
    user = repo.check_password(params[:name], params[:password])
    if user == nil
      @status = nil
      return 400, erb(:home_page)
    else
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect to("/"), 302
    end
  end

  get "/login" do
    return erb(:login)
  end

  get "/accounts" do
    if session[:user_name]
      @name = session[:user_name]
      return erb(:accounts)
    end
    redirect to("/login")
  end
end
