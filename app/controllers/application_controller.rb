require './config/environment'
require 'sinatra'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions 
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect to "/home"
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end
end
