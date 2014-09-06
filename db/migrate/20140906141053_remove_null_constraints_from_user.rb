class RemoveNullConstraintsFromUser < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :phone_number, :string, null: true
  end
end
