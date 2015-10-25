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

    # 合成するファイルを配列の{index}秒だけずらした一時ファイルを生成する
    flist_str = make_sliced_file(flist).join(" ")

    # ファイルの合成
    filepath = "public/audios/" + Time.current.strftime("%Y%m%d%H%M%S") + ".mp3"
    cmd = "sox -m #{flist_str} #{Rails.root}/#{filepath}"
    result = `#{cmd}`

    if $?
      Music.create(user_id: sound_log.user_id, filepath: filepath)
      return # success
    end
    return # error
  end

  # return file path list
  def make_sliced_file(flist)
    flist_sliced = []
    flist.each_with_index do |v, i|
      # 開始時のファイルはスライスしない
      if i == 0
        flist_sliced << v
      else
        tmp_file = "/tmp/sound_#{i}.mp3"
        silent_files = (Sound::SILENT_FILE_PATH + " ") * i
        cmd = "sox #{silent_files} #{v} #{tmp_file}"
        result = `#{cmd}`
        flist_sliced << tmp_file
      end
    end
    return flist_sliced
  end
end
