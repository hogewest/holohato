class CreateChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :channels do |t|
      t.string :channel_id, null: false, index: { unique: true }
      t.string :description, null: false

      t.timestamps
    end
  end
end
