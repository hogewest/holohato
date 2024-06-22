class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :video_id, null: false, index: { unique: true }
      t.integer :state, null: false, index: true
      t.integer :retry_count, null: false, default: 0

      t.timestamps
    end
  end
end
