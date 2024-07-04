# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to polymorphic_url(@comment.commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render 'comments/edit', id: params[:id], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to polymorphic_url(@comment.commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
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
