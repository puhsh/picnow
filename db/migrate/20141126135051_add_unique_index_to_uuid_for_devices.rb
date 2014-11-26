class AddUniqueIndexToUuidForDevices < ActiveRecord::Migration
  def change
    add_index :devices, :token, unique: true
  end
end
