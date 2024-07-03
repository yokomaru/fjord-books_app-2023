# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit
    render 'comments/edit'
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_url(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { render 'books/show', report_id: params[:report_id], status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to book_url(@comment.commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render 'comments/edit', id: params[:id], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to report_url, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
