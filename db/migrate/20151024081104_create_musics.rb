class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.integer :user_id
      t.string :filepath

      t.timestamps null: false
    end
  end
end
