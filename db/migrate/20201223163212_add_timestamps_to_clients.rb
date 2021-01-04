class AddTimestampsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :created_at, :datetime
    add_column :clients, :updated_at, :datetime
  end
end
