class TimeLogsController < ApplicationController
  # GET /time_logs
  # GET /time_logs.json
  def index
    @time_logs = TimeLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_logs }
    end
  end

  # GET /time_logs/1
  # GET /time_logs/1.json
  def show
    @time_log = TimeLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_log }
    end
  end

  # GET /time_logs/new
  # GET /time_logs/new.json
  def new
    @time_log = TimeLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_log }
    end
  end

  # GET /time_logs/1/edit
  def edit
    @time_log = TimeLog.find(params[:id])
  end

  # POST /time_logs
  # POST /time_logs.json
  def create
    @time_log = TimeLog.new(params[:time_log])

    respond_to do |format|
      if @time_log.save
        format.html { redirect_to @time_log, notice: 'Time log was successfully created.' }
        format.json { render json: @time_log, status: :created, location: @time_log }
      else
        format.html { render action: "new" }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_logs/1
  # PUT /time_logs/1.json
  def update
    @time_log = TimeLog.find(params[:id])

    respond_to do |format|
      if @time_log.update_attributes(params[:time_log])
        format.html { redirect_to @time_log, notice: 'Time log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_logs/1
  # DELETE /time_logs/1.json
  def destroy
    @time_log = TimeLog.find(params[:id])
    @time_log.destroy

    respond_to do |format|
      format.html { redirect_to time_logs_url }
      format.json { head :no_content }
    end
  end
end
