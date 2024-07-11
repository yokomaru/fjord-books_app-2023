# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'books/show', report_id: params[:report_id], status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
