class SoundLogsController < ApplicationController
  before_action :set_sound_log, only: [:show, :edit, :update, :destroy]

  # GET /sound_logs
  # GET /sound_logs.json
  def index
    @sound_logs = SoundLog.all
  end

  # GET /sound_logs/1
  # GET /sound_logs/1.json
  def show
  end

  # GET /sound_logs/new
  def new
    @sound_log = SoundLog.new
  end

  # GET /sound_logs/1/edit
  def edit
  end

  # POST /sound_logs
  # POST /sound_logs.json
  def create
    @sound_log = SoundLog.new(sound_log_params)

    respond_to do |format|
      if @sound_log.save
        format.html { redirect_to @sound_log, notice: 'Sound log was successfully created.' }
        format.json { render :show, status: :created, location: @sound_log }
      else
        format.html { render :new }
        format.json { render json: @sound_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sound_logs/1
  # PATCH/PUT /sound_logs/1.json
  def update
    respond_to do |format|
      if @sound_log.update(sound_log_params)
        format.html { redirect_to @sound_log, notice: 'Sound log was successfully updated.' }
        format.json { render :show, status: :ok, location: @sound_log }
      else
        format.html { render :edit }
        format.json { render json: @sound_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sound_logs/1
  # DELETE /sound_logs/1.json
  def destroy
    @sound_log.destroy
    respond_to do |format|
      format.html { redirect_to sound_logs_url, notice: 'Sound log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sound_log
      @sound_log = SoundLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sound_log_params
      params[:sound_log]
    end
end
