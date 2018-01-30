class CommentsController < ApplicationController

  post '/comments' do
    if logged_in? && !params[:comment][:content].empty?
      @comment = Comment.new(params[:comment])
      @routine = Routine.find(params[:comment][:routine_id])

      @comment.user_id = session[:id]
      @comment.routine_id = @routine.id

      @comment.save
    else
      flash.next[:message] = "Comments cannot be blank"
    end
    redirect to "/routines/#{@routine.id}"
  end

  # delete '/comments/:id/delete' do
  #   @comment = Comment.find(params[:id])
  #   if logged_in? && current_user.id == @comment.user_id
  #     @comment.delete
  #     redirect to "/routines/#{@routine.id}"
  #   else
  #     redirect to "/routines/#{@routine.id}"
  #   end
  # end

  ##example
  # def find_article!
  #   @article = Article.find_by_slug!(params[:article_slug])
  # end
end
