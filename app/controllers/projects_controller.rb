class ProjectsController < ApplicationController
  
  helper_method :sort_column, :sort_direction  
  before_filter :confirm_is_admin, :except => [:index, :show]
  
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @all_tasks = Task.where(:project_id => @project.id)
    @tasks = filtered_tasks.order(sort_column + " " + sort_direction)
    #@tasks_by_activity = Task.where(:project_id => @project.id).includes(:time_logs, :comments).order('comments.created_at desc')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
      format.js
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  def new_user    
    @project = Project.find(params[:id])
    if @project.users.length == 0
      @users_available = User.all
    else
      @users_available = User.not_involved_in(@project)
    end
    respond_to do |format|
      format.js
    end
  end  
  
  def add_user
    @project = Project.find(params[:id])
    @project.add_user(params[:new_user])
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  private
  
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