class ApplicationController < ActionController::Base
  
  protect_from_forgery
   
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  protected 
  
  def confirm_logged_in   
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to('/access/login')
      return false
    else
      return true
    end
  end
 
  def confirm_is_admin
    unless User.find_by_id(session[:user_id]).is_admin?
      flash[:error] = "Authorisation Error"
      redirect_no_auth
      false
    end
  end
  
  
  def confirm_is_user_or_admin    
    unless User.find_by_id(session[:user_id]).is_admin? || Task.find(params[:id]).user == User.find_by_id(session[:user_id]  )
      flash[:error] = "Authorisation Error"
      redirect_no_auth
      false
    end
  end
  
  
 private
 
 def redirect_no_auth
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to projects_path   
 end
 
end