class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @survey = Survey.find(params[:survey_id])
    @comments = @survey.comments.paginate(:page => params[:page], :per_page => 5).order('created_at ASC')
    render :partial => "list_comments", :content_type => 'text/html'
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @comment = @survey.comments.build(params[:comment])
    @comment.user = current_user
    @comments = @survey.comments.paginate(:page => params[:page], :per_page => 5).order('created_at ASC')
    if @comment.save
      if(request.xhr?)
        render :partial => "list_comments", :content_type => 'text/html'
      else
        redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id), :notice => 'Comment was created successfully.'
      end
    else
      head :nothing
    end
=begin
    respond_to do |format|
      if @comment.save
        format.js
        format.html do 
          puts "===========00000000000==#{request.xhr?}"
          redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id), :notice => 'Comment was created successfully.'
        end
      else
        format.html { redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id), :notice => 'Comment failed to create.' }
      end
    end
=end
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
