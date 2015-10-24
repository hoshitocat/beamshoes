class CreateSoundLogs < ActiveRecord::Migration
  def change
    create_table :sound_logs do |t|
      t.integer :user_id
      t.integer :sound_id
      t.datetime :detect_time

      t.timestamps null: false
    end
  end
end
