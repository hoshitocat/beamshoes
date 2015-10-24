class SoundLogsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @sound_log = SoundLog.new(create_params)

    respond_to do |format|
      if @sound_log.save
        format.json { render json: { status: :created, location: @sound_log } }
      else
        format.json { render json: @sound_log.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_params
    params.permit(:user_id, :sound_id, :detect_time)
  end
end
