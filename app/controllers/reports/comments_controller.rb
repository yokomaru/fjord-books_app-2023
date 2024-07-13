# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  def create
    @report = Report.find(params[:report_id])
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'reports/show', report_id: params[:report_id], status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
