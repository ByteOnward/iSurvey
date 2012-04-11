class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @survey = Survey.find(params[:survey_id])
    @comments = @survey.comments.paginate(:page => params[:page], :per_page => 10).order('created_at ASC')
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @comment = @survey.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id), :notice => 'Comment was created successfully.'}
      else
        format.html { redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id), :notice => 'Comment failed to create.' }
      end
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @comment = @survey.comments.build(params[:comment])
  end

  def destroy
    @survey = Survey.find(params[:survey_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id)}
    end
  end
end
