class ProductsController < ApplicationController

  get '/products/new' do
    if logged_in?
      erb :'products/new'
    else
      redirect to '/login'
    end
  end

  post '/products' do
    if logged_in? && !params[:product][:name].empty?

      if Product.find_by(name: params[:product][:name])
        flash.next[:message] = "This product already exists. Please add a new product or choose from the products below."
        redirect to '/products/new'
      else
        @product = Product.create(
          name: params[:product][:name],
          category: params[:product][:category],
          ingredients: params[:product][:ingredients],
          notes: params[:product][:notes],
          )
        redirect to "/products/#{@product.id}"
      end

    elsif params[:product][:name].empty?
      flash.next[:message] = "You may not leave the name field blank."
      redirect '/products/new'
    else
      redirect '/login'
    end
  end

  get '/products' do
    if logged_in?
      @products = Product.all
      erb :'products/index'
    else
      redirect to '/login'
    end
  end

  get '/products/:id' do
    if logged_in?
      @product = Product.find(params[:id])
      erb :'/products/show'
    else
      redirect to '/login'
    end
  end

  get '/products/:id/edit' do
    if logged_in?
      @product = Product.find(params[:id])
      erb :'/products/edit'
    else
      redirect to '/login'
    end
  end

  patch '/products/:id' do
    if logged_in?
      @product = Product.find(params[:id])

      if !params[:product][:name].empty?
        @product.name = params[:product][:name]
        @product.category = params[:product][:category]
        @product.ingredients = params[:product][:ingredients]
        @product.notes = params[:product][:notes]
        @product.save
        redirect to "/products/#{@product.id}"
      else
        flash.next[:message] = "You may not leave the name field blank."
        redirect to "/products/#{@product.id}/edit"
      end
    else
      redirect to '/login'
    end
  end

  ############ DELETE #############
  ## I don't want the user to have this functionality

  # delete '/products/:id/delete' do
  #   @product = Product.find(params[:id])
  #   if logged_in?
  #     @product.delete
  #     # flash[:message] = "This product has been deleted"
  #     redirect to '/products'
  #   else
  #     redirect to '/login'
  #   end
  # end
end
