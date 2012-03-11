class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @survey = Survey.find(params[:survey_id])
    @comments = @survey.comments.paginate(:page => params[:page], :per_page => 5).order('created_at ASC')
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @comment = @survey.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to survey_comments_url, :notice => 'Comment was created successfully.'}
      else
        format.html { redirect_to survey_comments_url, :notice => 'Comment failed to create.' }
      end
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @comment = @survey.comments.build(params[:comment])
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to survey_comments_url }
    end
  end
end
