class StatisticsController < ApplicationController
  
  def search
    records = Record.where('user_id = ? and survey_id = ?', params[:user_id], params[:survey_id])
    @survey = Survey.find(params[:survey_id])
    @choices = records.reduce([]) do|a, r|
      a << r.choice_id
    end
    if records.size == 0 && survey_open
      flash[:alert] = "You haven't participate this survey."
    elsif !survey_open
      flash[:alert] = "The survey has been closed."
    end
  end

  def survey_open
    @survey = Survey.find(params[:survey_id])
    if (@survey.duration > (Time.now.day - @survey.created_at.day))
      return true
    else
      return false
    end
  end

end
