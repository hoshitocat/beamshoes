class SoundLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :sound

  RECORDING_TIME = 10

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
