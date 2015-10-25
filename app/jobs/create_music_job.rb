class CreateMusicJob < ActiveJob::Base
  queue_as :default

  def perform(sound_log)

    # recordingが終了するまでsleep
    sleep(SoundLog::RECORDING_TIME)

    # find target sound log
    sounds = SoundLog.where(
      user_id: sound_log.user_id,
      detect_time: [sound_log.detect_time..sound_log.detect_time + SoundLog::RECORDING_TIME]
    )

    # 無音ファイルで初期化
    flist = Array.new(SoundLog::RECORDING_TIME, Sound::SILENT_FILE_PATH)

    # 1秒ごとに再生するファイルのパスを格納した配列を作成する
    start_time = sound_log.detect_time
    sounds.each do |log|
      flist[log.detect_time - start_time] = Sound::SOUND_FILE_PATH
    end
    flist_str = flist.join(" ")

    fname = Time.current.strftime("%Y%m%d%H%M%S")
    cmd = "sox #{flist_str} #{Rails.root}/public/musics/#{fname}.mp3"
    result = `#{cmd}`

    if $?
      return # success
    end
    return # error
  end
end
