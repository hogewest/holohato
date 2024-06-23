class AddReferencesToVideos < ActiveRecord::Migration[7.1]
  def change
    add_reference :videos, :channel, null: false, foreign_key: true
  end
end
