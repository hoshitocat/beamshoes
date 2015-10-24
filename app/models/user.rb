class User < ActiveRecord::Base
  has_many :sound_logs
  has_many :musics
end
