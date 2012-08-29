class UserController < ApplicationController
  
  before_filter :confirm_self, :except => [:show, :index]
  
  
  def index
    list
    render('list')
  end

  ###### CRUD METHODS ######

  # CREATE

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "User Created."
      redirect_to('list')
    else
      flash[:notice] = "User Create Failed."
      render('new')
    end
    
  end

  # READ
  def list
    @users = User.order("users.id ASC")
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.by_user(@user.id).order("deadline asc").group_by{ |t| t.project }    
    @time_logs = TimeLog.by_user(@user.id)       
  end

  # UPDATE
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated."
      redirect_to(:action => 'show', :id => @user.id)
    else
      render('edit')
    end
  end

  # DELETE
  def delete
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted."
    redirect_to(:action => 'list')
  end

  
  
  def confirm_self   
    unless User.find_by_id(session[:user_id]).is_admin? || session[:user_id] == params[:id]
      flash[:error] = "Authorisation Error"
      redirect_no_auth
      false
    end
  end


end
