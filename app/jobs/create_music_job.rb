class CreateMusicJob < ActiveJob::Base
  queue_as :default

  def perform(sound_log)

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
