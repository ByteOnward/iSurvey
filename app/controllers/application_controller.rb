class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user 
      redirect_to '/roles/unauthorized', :alert => exception.message
    else
      redirect_to '/users/login', :alert => exception.message
    end    
  end
  
  private 
  def current_ability
    @current_ability ||= Ability.new(current_user, request.remote_ip);
  end
end
