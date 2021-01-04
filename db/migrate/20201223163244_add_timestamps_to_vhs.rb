class AddTimestampsToVhs < ActiveRecord::Migration[5.2]
  def change
    add_column :vhs, :created_at, :datetime
    add_column :vhs, :updated_at, :datetime
  end
end
