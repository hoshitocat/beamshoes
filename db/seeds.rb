# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SoundLog.create([
  {user_id: 1, sound_id: 1, detect_time: Time.new(2015, 10, 24, 00, 00, 00)},
  {user_id: 1, sound_id: 1, detect_time: Time.new(2015, 10, 24, 00, 00, 10)},
  {user_id: 1, sound_id: 1, detect_time: Time.new(2015, 10, 24, 00, 00, 20)},
  {user_id: 1, sound_id: 1, detect_time: Time.new(2015, 10, 24, 00, 00, 30)},
  {user_id: 1, sound_id: 1, detect_time: Time.new(2015, 10, 24, 00, 00, 40)}
])
