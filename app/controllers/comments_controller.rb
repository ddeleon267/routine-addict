class CommentsController < ApplicationController

  post '/comments' do
    @comment = Comment.new(params[:comment])
    @routine = Routine.find(params[:comment][:routine_id])

    if logged_in? && !params[:comment][:content].empty?
      @comment.user_id = session[:id]
      @comment.routine_id = @routine.id
      @comment.save
    end
    redirect to "/routines/#{@routine.id}"
  end

  get '/comments/:id/edit' do
    @comment = Comment.find(params[:id])
    if logged_in? && current_user.id == @comment.user_id
      erb :'/comments/edit'
    else
      redirect to '/login'
    end
  end

  patch '/comments/:id' do
    @comment = Comment.find(params[:id])
    if logged_in? && current_user.id == @comment.user_id && !params[:comment][:content].empty?
      @comment.update(params[:comment])
      @comment.save
    else
      flash.next[:message] = "Comments cannot be blank"
    end
    redirect to "/routines/#{@comment.routine_id}"
  end

  delete '/comments/:id/delete' do
    @comment = Comment.find(params[:id])

    if logged_in? && current_user.id == @comment.user_id
      @comment.delete
      redirect to "/routines/#{@comment.routine_id}"
    else
      redirect to "/routines/#{@comment.routine_id}"
    end
  end

end
