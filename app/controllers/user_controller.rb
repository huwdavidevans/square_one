class UserController < ApplicationController
  
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
      redirect_to(:action => 'list')
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

end
