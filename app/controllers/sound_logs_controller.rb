class SoundLogsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def index
  end

  def new
  end

  def create
    @sound_log = SoundLog.new(create_params)

    respond_to do |format|
      if @sound_log.save
        if SoundLog.can_enqueue?(@sound_log)
          CreateMusicJob.perform_later(@sound_log)
        end

        format.json { render json: { status: :created, location: @sound_log } }
      else
        format.json { render json: @sound_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def bulk_create
    SoundLog.bulk_create(bulk_create_params)
    redirect_to :back
  end

  private

  def create_params
    params.permit(:user_id, :sound_id, :detect_time)
  end

  def bulk_create_params
    strong_params = params.permit(:user_id, :sound_id, :detect_time)
    strong_params[:detect_time] = strong_params[:detect_time].split(',')
    strong_params
  end
end
