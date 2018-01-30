class CommentsController < ApplicationController

  post '/comments' do
    binding.pry
    #if logged_in? && !params[:comment][:content].empty?

    #is this right? this doesn't seem right. idk
    #@routine = Routine.find(params[:id])

      #@comment = Comment.new(params[:comment])
      #@comment.user_id = session[:id]
      #@comment.routine_id = @routine.id
      #@routine.save
      #redirect to "/routines/#{@routine.id}"
    # else
    #   flash.next[:message] = "Comments cannot be blank"
    #   redirect to "/routines/#{@routine.id}"
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
