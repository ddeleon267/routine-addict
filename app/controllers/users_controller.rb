class UsersController < ApplicationController
############ LOGIN ############

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to "/home"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #if user exists and pasword matches
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/home"
    elsif @user && !@user.authenticate(params[:password])
      flash.next[:message] = "Invalid password."
      redirect to '/login'
    else
      flash.next[:message] = "No such user was found. Please try again."
      redirect to '/login'
    end
  end

########### SIGNUP #############

get '/signup' do
  if !logged_in?
    erb :'/users/signup'
  else
    redirect to "/home"
  end
end

post '/signup' do
  if User.find_by(username: params[:username])
    flash.next[:message] = "That username is taken. Please try again."
    redirect to '/signup'
  elsif User.find_by(email: params[:email])
    flash.next[:message] = "That email is registered to another user. Please log in or try again."
    redirect to '/signup'
  else
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:id] = @user.id
        redirect to "/home"
      else
        flash.next[:message] = "Password must be 6+ characters in length, and email must be in standard format."
        redirect to '/signup'
      end
  end
end

############ SHOW USER ############
  get '/home' do
    @user = current_user

    if logged_in?
      @routines = Routine.all
      @products = Product.all
      @users = User.all
      erb :'/users/home'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      @user_routines = @user.routines
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

############ LOGOUT ############

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
