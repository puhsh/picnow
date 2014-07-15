class AddNameToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :name, :string, after: :id, null: false, default: ''
  end
end
