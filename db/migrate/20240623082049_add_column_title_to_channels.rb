class AddColumnTitleToChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :title, :string, null: false
  end
end
