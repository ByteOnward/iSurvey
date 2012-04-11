class StatisticsController < ApplicationController
  
  def search
    records = Record.where('user_id = ? and survey_id = ?', params[:user_id], params[:survey_id])
    @survey = Survey.find(params[:survey_id])
    @comments = @survey.comments.paginate(:page => params[:page], :per_page => 5).order('created_at ASC')
    @choices = records.reduce([]) do|a, r|
      a << r.choice_id
    end
    if records.size == 0
      flash[:alert] = "You haven't participate this survey."
    end    
  end

end
