class Sound < ActiveRecord::Base
  has_many :sound_logs

  SOUND_FILE_PATH = "#{Rails.root}/public/sounds/saitei.mp3"
  SILENT_FILE_PATH = "#{Rails.root}/public/sounds/silent.mp3"
end
