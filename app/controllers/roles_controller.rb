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
  
  def users
    @users = User.all
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
