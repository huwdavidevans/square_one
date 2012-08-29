class CommentsController < ApplicationController
  
  before_filter :find_task
  before_filter :confirm_is_admin, :except => [:show, :new, :create]

    
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end
  
  
  

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end


  # GET /comments/new
  # GET /comments/new.json
  def new
    
    # should get user id here too
    @comment = Comment.new(:task_id => @task.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end


  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    puts YAML::dump(@task)
    
    respond_to do |format|
      if @comment.save
        @task.save
        format.html { redirect_to @comment.task, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new"}
        # redirect_to(:action => 'new', :id => @task.id)
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end




  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment.task, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
  
  
  def new_reply
    @original_comment = Comment.find_by_id(params[:id])
    @reply = Comment.new()    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
 def create_reply
    @original_comment = Comment.find_by_id(params[:comment_id])
    @reply = Comment.new(params[:reply])
    @original_comment.replies << @reply
    respond_to do |format|
      if @original_comment.save
        @task.save
        flash[:success] = "Reply added"
        format.js
        format.html { redirect_to @task }
        format.json { head :no_content }
      else
        flash[:error] = "Reply not successful"
        format.html { redirect_to @task }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  
  private

   def find_task
     if params[:task_id]
       @task = Task.find_by_id(params[:task_id])
     elsif params[:comment][:task_id]
       @task = Task.find_by_id(params[:comment][:task_id])
     end 
   end
  
end