class SurveysController < ApplicationController
  
  before_filter :authenticate_user!
#  authorize_resource
  load_and_authorize_resource :except => [:index, :new, :take, :stats]
  
  # GET /surveys
  # GET /surveys.json
  def index
    if current_user.role? :admin
      @surveys = Survey.all
    else
      roles = current_user.roles.reduce(['Public']){|a, role| a << role.name}
      @surveys = Survey.where('"surveys"."group" in (?) or user_id = ?', roles, current_user.id)
      #@surveys = Survey.where(:group => current_user.roles.reduce(['Public']){|a, role| a << role.name})
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end
  
  
  # GET /surveys/new
  # GET /surveys/new.json
  def new
    @survey = Survey.new
    3.times do
      question = @survey.questions.build
        3.times do
          question.choices.build
        end
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
#    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.json
  def create
#    @survey = Survey.new(params[:survey])
    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: "new" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.json
  def update
#    @survey = Survey.find(params[:id])
    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
#    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :no_content }
    end
  end
  
  
  def stats
    @survey = Survey.find(params[:id]);
    authorize! :read, @survey, :message => "Unable to read this article." 
    @stats = Statistics.where("survey_id = ?", params[:id]).first    
    @result = @stats ? stats_of_percentage(@stats, @survey) : Hash.new(0)
  end
  
  def take          
    authorize! :read, Survey.find(params[:id]), :message => "Unable to read this article." 
    status = allow_user_take_survey && take_survey    
    respond_to do |format|
      if status
        format.html { redirect_to action: 'stats', notice: 'Thank you for your participation.' }
        format.json { render json: @stats, status: :created, location: @survey }
      else
        error = @stats ? @stats.errors : "You have already taken this survey."
        @survey = Survey.find(params[:id])
        format.html { redirect_to @survey, alert: error }
        format.json { render json: error, status: :unprocessable_entity }
      end
    end
  end

  
  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey }
    end
  end
 
  private
    def take_survey
      status = false
      @stats = Statistics.where("survey_id=?", params[:id]).first
      s = Statistics.new(params[:statistics])
      if @stats
        new_records = @stats.records + s.records
        status = @stats.update_attribute(:records, new_records);
      else
        @stats = s
        status = @stats.save
      end
      return status
    end
    
    def allow_user_take_survey
      record = Record.where("user_id = ? and survey_id = ?", current_user.id, params[:id]).first
      if record
        return false
      else
        return true
      end
    end
    
    def stats_by_questions(stats)
      stats.records.reduce(Hash.new(0)){|m, r| m.tap{|ht| ht[r.question_id] += 1}}
    end

    def stats_by_choices(stats)
      stats.records.reduce(Hash.new(0)){|m, r| m.tap{|ht| ht[r.choice_id] += 1}}
    end
    
    def stats_of_percentage(stats, survey)
      questions = stats_by_questions(stats)
      choices = stats_by_choices(stats)
      result = {}
      survey.questions.each do |q|
        q.choices.each do |c|
          result[c.id] = choices[c.id] * 1.0 / questions[q.id]
        end
      end
      return result  
    end
    
 
end
