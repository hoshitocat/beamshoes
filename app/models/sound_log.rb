class SoundLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :sound

  RECORDING_TIME = 10

  def self.bulk_create(params = {})
    return if params.blank?

    sound_logs = []
    params[:detect_time].each do |detect_time|
      sound_logs << SoundLog.new(user_id: params[:user_id], sound_id: params[:sound_id], detect_time: Time.at(detect_time.to_i))
    end
    SoundLog.import sound_logs
  end

  private
    # ジョブをキューに入れるかどうかの判定のみを行うメソッド
    def self.can_enqueue?(sound_log)
      if self.where(
        detect_time: [sound_log.detect_time - self::RECORDING_TIME..sound_log.detect_time]
      ).exists?
        return false
      end

      return true
    end
end
