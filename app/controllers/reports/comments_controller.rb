# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit
    render 'comments/edit'
  end

  def create
    @report = Report.find(params[:report_id])
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { render 'reports/show', report_id: params[:report_id], status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to report_url(@comment.commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to book_url, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
