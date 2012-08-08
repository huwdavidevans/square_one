class AccessController < ApplicationController
     
  def index
    menu
    render('menu')
  end
  
  def menu
    # text and links
  end

  def login
    #form
  end
  
  def switch    
    auth_user = User.find_by_id(params[:user][:id])    
    session[:user_id] = auth_user.id
    session[:user_name] = auth_user.name
    flash[:success] = "#{auth_user.name} successfully logged in"
      redirect_to(projects_url)
  end
  
  
  def attempt_login
    auth_user = User.authenticate(params[:username], params[:password])
    if auth_user
      session[:user_id] = auth_user.id
      session[:user_name] = auth_user.name
      flash[:success] = "#{auth_user.name} successfully logged in"
      redirect_to(projects_url)
    else
      flash[:error] = "Invalid username/password combination"
      redirect_to(:action => 'login')
    end
  end
  
  
  def logout
      flash[:notice] = "#{session[:user_name]} now logged out"
      session[:user_id] = nil
      session[:user_name] = nil
      redirect_to(:action => 'login')
  end
  
  
end
