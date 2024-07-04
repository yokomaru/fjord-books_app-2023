# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
