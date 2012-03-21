class RolesController < ApplicationController
  
  authorize_resource
  skip_authorize_resource :only => :unauthorized
  
  def index
    @roles = Role.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end
  
  def add 
    @role = Role.new(params[:role])
    if @role.save
      render :text => '{"status": "success"}', :content_type => 'applicatoin/json'
    else
      render :text => '{"status": "failure"}', :content_type => 'applicatoin/json'
    end
  end
  
  def show
      role = Role.find(params[:id])
      if role
        render :json => role
      else
        render :status => 500
      end
  end
  
  def update
    role = Role.find(params[:id])
    role2 = params[:role]
    if(role.name == role2[:name] && role.group == role2[:group])
      render :json => '{"status": "nochanged"}'
    else
      if role.update_attributes(params[:role])
        render :json => '{"status": "success"}'
      else
        render :status => 500
      end
    end
  end
  
  def users
    search_string = params[:search_string] || ''
    @users = User.where("email like ?", "%#{search_string}%").paginate(:page => params[:page], :per_page => 15).order('email ASC')
    @roles = Role.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def grant
    user_ids = (params[:users] || {}).reduce([]){|arr, user| arr << user[0] }
    users = User.find(user_ids)
    role = Role.find(params[:role])
   
    begin
      new_users = users - role.users;
      if new_users == [] 
        render :text => '{"status": "nochanged"}', :content_type => 'applicatoin/json'
      else
        role.users << new_users
        render :text => '{"status": "success"}', :content_type => 'applicatoin/json'
      end
    rescue => error
      render :text => "#{error}", :content_type => 'text/plain'
    end
  end
  
  def ungrant
    user_ids = (params[:users] || {}).reduce([]){|arr, user| arr << user[0] }
    users = User.find(user_ids)
    role = Role.find(params[:role]) 
    begin
      removed_users = role.users & users
      if removed_users == [] 
        render :text => '{"status": "nochanged"}', :content_type => 'applicatoin/json'
      else
        puts role.users.delete(removed_users);
        render :text => '{"status": "success"}', :content_type => 'applicatoin/json'
      end
    rescue => error
      render :text => "#{error}", :content_type => 'text/plain'
    end
  end
  
  def unauthorized
    
  end
    
end
