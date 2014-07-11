class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.datetime :last_photo_received_at
      t.timestamps
    end
  end
end
