class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :video_id, null: false, index: { unique: true }
      t.string :title, null: false
      t.datetime :published_at, null: false
      t.json :thumbnails, null: false

      t.timestamps
    end
  end
end
