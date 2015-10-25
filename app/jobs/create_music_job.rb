class CreateMusicJob < ActiveJob::Base
  queue_as :default

  def perform(sound_log)

    # 演奏開始以外のログのときはジョブを終了
    if SoundLog.where(
      detect_time: [sound_log.detect_time - SoundLog::RECORDING_TIME..sound_log.detect_time]
    ).exists?
      return
    end

    # recordingが終了するまでsleep
    sleep(SoundLog::RECORDING_TIME)

    # find sound log
    sounds = SoundLog.where("detect_time >= ?", sound_log.detect_time)

    # create music file
    filelist = []
    sounds.each do |k, v|
      puts k
    end

  end

end
