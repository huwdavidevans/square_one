class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  
  
  before_filter :find_project
  
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  
  
  # def index  
  #     @tasks = Task.order("tasks.deadline DESC").where(:project_id => @project.id)
  #     respond_to do |format|
  #       format.html # index.html.erb
  #       format.json { render json: @tasks }
  #     end    
  #   end


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
    end
  end





  # POST /tasks
  # POST /tasks.json
  def create    
    @task = Task.new(params[:task])
    @task.project_id = @project.id;
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, :project_id => @task.project_id, notice: 'Task was successfully created.' }
        format.json { render json: @task, :project_id => @task.project_id, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end      
    end
    
    
  end
  
  
  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
  
      
      if @task.update_attributes(params[:task])
        flash[:notice] = "task updated."
        redirect_to(:action => 'show', :id => @task.id)
      else
        render('edit')
      end
      
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, :project_id => @task.project_id}
      format.json { head :no_content }
    end
  end
  
  
  private
  
  def find_project
    if params[:project_id]
      @project = Project.find_by_id(params[:project_id])
    end 
  end


end