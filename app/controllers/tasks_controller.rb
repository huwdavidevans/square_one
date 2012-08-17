class TasksController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  before_filter :find_project
  before_filter :confirm_is_admin, :except => [:show, :mark_complete]
  
  
  def mark_complete
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(:complete => 1)
        flash[:success] = "Task Completed."
        format.html { redirect_to @task }
        format.json { render json: @task }
      else
        flash[:error] = "Task Not Completed."
        format.html { redirect_to @task }
        format.json { render json: @task }
      end
    end
  end
  
  
  def re_open
    @task = Task.find(params[:id])
    respond_to do |format|
      if  @task.update_attributes(:complete => 0)
        flash[:success] = "Task Reopened."
        format.html { redirect_to @task }
        format.json { render json: @task }
      else
        flash[:error] = "Task Not reopened."
        format.html { redirect_to @task }
        format.json { render json: @task }
      end
    end
  end

  
  
  def index
    @all_tasks = Task.scoped
    @tasks = filtered_tasks.order(sort_column + " " + sort_direction)
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  
  


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @project = @task.project
    @user = @task.user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end




  # GET /tasks/new
  # GET /tasks/new.json
  def new   
    @task = Task.new(:project_id => @project.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
      format.js
    end
  end





  # POST /tasks
  # POST /tasks.json
  def create    
    @task = Task.new(params[:task])
    @task.project_id = @project.id;
    
    respond_to do |format|
      if @task.save
        flash[:success] = "Task was successfully created."
        format.html { redirect_to @task.project }
        format.json { render json: @task, status: :created, location: @task }
      else
        flash[:error] = "Task not created."
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end      
    end
    
    
  end
  
  
  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @project = @task.project
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])    
      if @task.update_attributes(params[:task])
        flash[:success] = "Task updated."
        redirect_to(:action => 'show', :id => @task.id)
      else
        flash[:error] = "Task not updated."
        render('edit')
      end      
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy    
    @task = Task.find(params[:id])
    @project = @task.project
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @project}
      format.json { head :no_content }
    end
  end
  
  
  private
  
  def find_project
    if params[:project_id]  
      @project = Project.find_by_id(params[:project_id])
    end 
  end  
  
  def filtered_tasks
     %w[not_started completed in_progress].include?(params[:state]) ? @all_tasks.send(params[:state].to_sym) : @all_tasks 
  end
  
  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "deadline"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end