class RoutinesController < ApplicationController

  ############ CREATE ###########
  get '/routines/new' do
    if logged_in?
      erb :'routines/new'
    else
      redirect to '/login'
    end
  end

  post '/routines' do
    if logged_in? && !params[:routine][:name].empty? && !params[:routine][:description].empty?
      @routine = Routine.new(params[:routine])
      @routine.user_id = session[:id]
      @routine.save
      erb :'routines/show'
    else
      redirect '/routines/new'
    end
  end

  ############ READ ###########
  get '/routines' do
    if logged_in?
      @routines = current_user.routines.all
      erb :'/routines/index'
    else
      redirect to '/login'
    end
  end

  get '/routines/:id' do
    if logged_in?
      @routine = Routine.find(params[:id])
      erb :'/routines/show'
    else
      redirect to '/login'
    end
  end

  ############ UPDATE ###########
  get '/routines/:id/edit' do
    @routine = Routine.find(params[:id])
    if logged_in? && current_user.id == @routine.user_id
      erb :'/routines/edit'
    else
      redirect to '/login'
    end
  end

  patch '/routines/:id' do
    @routine = Routine.find(params[:id])

    if current_user.id == @routine.user_id
      last_name = @routine.name
      params[:routine][:name].empty? ? @routine.update(name: last_name) : @routine.update(name: params[:routine][:name])

      last_description = @routine.description
      params[:routine][:description].empty? ? @routine.update(description: last_description) : @routine.update(description: params[:routine][:description])

      @routine.product_ids.clear
      @routine.product_ids = params[:routine][:product_ids]

      if @routine.save
        redirect to "/routines/#{@routine.id}"
      else
        flash.next[:message] = "Something went wrong. Make sure no fields are left blank, and at least one product is chosen."
        redirect to "/routines/#{@routine.id}/edit"
      end
    else
      redirect to "/routines"
    end
	end

  ############ DELETE #############

  delete '/routines/:id/delete' do
    @routine = Routine.find(params[:id])
    if logged_in? && @routine.user == current_user
      @routine.delete
      flash.next[:message] = "Routine successfully deleted."
      redirect to '/routines'
    else
      redirect to '/login'
    end
  end
end
