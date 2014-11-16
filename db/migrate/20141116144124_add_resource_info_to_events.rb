class AddResourceInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :resource_id, :integer
    add_column :events, :resource_type, :string

    add_index :events, :resource_id
    add_index :events, :resource_type
  end
end
