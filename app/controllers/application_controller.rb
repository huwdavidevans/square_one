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
 
 
 
 
end
