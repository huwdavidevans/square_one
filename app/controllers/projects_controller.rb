class ProjectsController < ApplicationController
  
  helper_method :sort_column, :sort_direction  
  before_filter :confirm_is_admin, :except => [:index, :show]
  
  # GET /projects
  # GET /projects.json
  def index 

    if params[:users] && !params[:users].empty?
     @filtered_users = params[:users].map { |s| s.to_i }
    else
     @filtered_users = User.all.collect(&:id)
    end

    if params[:types] && !params[:types].empty?
      @filtered_types = params[:types].map { |s| s.to_i }
    else
      @filtered_types = ProjectType.all.collect(&:id)
    end

    @all_projects = Project.all  
    @projects = Project.joins(:users).where('user_id IN (?)', @filtered_users).uniq.joins(:project_type).where('project_type_id IN (?)', @filtered_types)
      
    @projects = @projects.order(sort_column + " " + sort_direction)


    #@projects = Project.joins(:users) & User.id_exists_in(@filtered_users)  

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @projects }
    end
    
  end
  
  
  def toggle
    
    if params[:users] && !params[:users].empty?
      @filtered_users = params[:users].map { |s| s.to_i }
    else
      @filtered_users = User.all.collect(&:id)
    end        
    if params[:user] && !params[:user].empty?
      @filtered_users.include?(params[:user].to_i) ? @filtered_users.delete(params[:user].to_i) : @filtered_users << params[:user].to_i
    end
    
    
    if params[:types] && !params[:types].empty?
      @filtered_types = params[:types].map { |s| s.to_i }
    else
      @filtered_types = ProjectType.all.collect(&:id)
    end
    if params[:type] && !params[:type].empty?
      @filtered_types.include?(params[:type].to_i) ? @filtered_types.delete(params[:type].to_i) : @filtered_types << params[:type].to_i
    end
    
    respond_to do |format|
      format.html { redirect_to :action=>:index, :users=>@filtered_users, :types=>@filtered_types}
      format.js { redirect_to :action=>:index, :users=>@filtered_users, :types=>@filtered_types}
    end

  end
  

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @all_tasks = Task.where(:project_id => @project.id)   
    @filtered_user = User.find_by_id(filtered_user_id)    
    @user_tasks = @all_tasks.by_user(filtered_user_id).order(sort_column + " " + sort_direction)    
    @tasks = @user_tasks.send(filtered_task_state)   
    #@tasks_by_activity = Task.where(:project_id => @project.id).includes(:time_logs, :comments).order('comments.created_at desc')
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
      format.js
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
  
  
  def remove_user    
    @project = Project.find(params[:id])
    @del_user = User.find_by_id(params[:user_id])
    @project.users.delete(@del_user)
    @project.save
    
    respond_to do |format|
      format.js
      format.html { redirect_to edit_project_path(@project) }
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
    
    @all_tasks = Task.where(:project_id => @project.id)
    
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
  
  def filtered_task_state
     %w[not_started completed in_progress].include?(params[:state]) ? params[:state].to_sym : :scoped 
  end
  
  def filtered_user_id
    @all_tasks.all(:select => :user_id).collect(&:user_id).uniq.include?( params[:user_id].to_i ) ? params[:user_id].to_i  :  nil
  end
  
  def project_sort_column
    Project.column_names.include?(params[:sort]) ? params[:sort] : "deadline"
  end
  
  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "deadline"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end