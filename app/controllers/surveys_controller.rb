class SurveysController < ApplicationController
  
  before_filter :authenticate_user!
#  authorize_resource
  load_and_authorize_resource :except => [:index, :new, :take, :stats]
  
  # GET /surveys
  # GET /surveys.json
  def index
    if current_user.role? :admin
      #@surveys = Survey.all
      @surveys = Survey.paginate(:page => params[:page], :per_page => 12).order('updated_at DESC')
    else
      roles = current_user.roles.reduce(['Public']){|a, role| a << role.name}
      @surveys = Survey.where('"surveys"."group" in (?) or user_id = ?', roles, current_user.id).paginate(:page => params[:page], :per_page => 12).order('updated_at DESC')
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
    is_new = true
    if params[:id]
      begin
        clone_survey Survey.find(params[:id]), @survey
        is_new = false
      rescue ActiveRecord::RecordNotFound => e
        #do nothing.
      end
    end
    if is_new     
      3.times do
        question = @survey.questions.build
          3.times do
            question.choices.build
          end
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
	      if @survey.group != 'Public'
	        @users = Role.find_by_name(@survey.group).users
	        @users.each do |user|
	          Notifier.survey_inviter(@survey, user).deliver
	        end
	      end
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
    result_by_choices, result_by_users = @stats ? stats_of_percentage(@stats, @survey) : [Hash.new(0), Hash.new(0)]
    if @survey.group == 'Public'
      @user_count = User.all.size 
    else
      @user_count = Role.where('name = ?', @survey.group).first.users.size
    end
    users = Record.where("survey_id = ?", @survey.id).select(:user_id).uniq
    puts users #BUG BUG BUG, here make sure the sql is laoded.
    @take_user_count = users.size  
    if params[:choices]
      @result = result_by_choices
      flash[:alert] = 'The results are counted according to choices.'
    else
      @result = result_by_users
      flash[:alert] = 'The results are counted according to users.'
    end  
  end
  
  def take       
    @survey = Survey.find(params[:id])  
    authorize! :read, @survey, :message => "Unable to read this article." 
    status = allow_user_take_survey && take_survey    
    respond_to do |format|
      if status
        format.html { redirect_to survey_comments_path(@survey), notice: 'Thank you for your participation.' }
        format.json { render json: @stats, status: :created, location: @survey }
      else
        error = @stats ? @stats.errors : "You have already taken this survey."
        format.html { redirect_to survey_comments_path(@survey), alert: error }
        format.json { render json: error, status: :unprocessable_entity }
      end
    end
  end

  
  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])
    if allow_user_take_survey
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @survey }
      end
    else
      respond_to do |format|
        format.html {redirect_to url_for(:action => 'search', :controller => 'statistics', :user_id => current_user.id, :survey_id => @survey.id)}
      end
    end
  end

  def search
    search_string = params[:search_string] || ''
    @surveys = Survey.where("name like ?", "%#{search_string}%").paginate(:page => params[:page], :per_page => 12).order('updated_at DESC')
    respond_to do |format|
      format.html
      format.json { render json: @surveys }
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
    
    def users_for_questions(stats)
      stats.records.reduce({}) do|m, r| 
        m.tap do |ht|
          unless ht[r.question_id]
            ht[r.question_id] = Set.new
          end
          ht[r.question_id] << r.user_id
        end
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
      users = users_for_questions(stats)
      result = {}
      result_by_users = {}
      survey.questions.each do |q|
        q.choices.each do |c|
          result[c.id] = [choices[c.id], questions[q.id]]
          result_by_users[c.id] = [choices[c.id], users[q.id].size]
        end
      end
      return result, result_by_users
    end
    
    def clone_survey src, dest
      dest.name = src.name
      dest.desc = src.desc
      src.questions.each do |q|
        question = dest.questions.build
        question.title = q.title
        q.choices.each do|c|
          choice = question.choices.build
          choice.content = c.content
        end
      end
    end
    
 
end
