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

    if logged_in?
      @routine = Routine.find(params[:id])
      erb :'/routines/edit'
    else
      redirect to '/login'
    end
  end

  patch '/routines/:id' do
    @routine = Routine.find(params[:id])

    if current_user.id == @routine.user_id
      last_name = @routine.name
      # last_products = @routine.products  ##this will break and make it angry
      last_description = @routine.description
	    @routine.update(name: params[:routine][:name])
      @routine.products.clear
      binding.pry
      params[:routine][:product_ids].map do |product|
        i = product.to_i
        @routine.products << Product.find(i)
      end

      #what I had before
      # @routine.routine_products.build(product_id: i)
      # @routine.update(products: params[:routine][:products])
      @routine.update(description: params[:routine][:description])
      @routine.update(name: last_name) if params[:routine][:name].empty?
      # @routine.update(products: last_products) if params[:routine][:products].empty?
      @routine.update(description: last_description) if params[:routine][:description].empty?

      if @routine.save
        redirect to "/routines/#{@routine.id}"
      else
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
