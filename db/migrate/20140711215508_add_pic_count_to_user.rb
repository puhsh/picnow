class AddPicCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :pic_now_count, :integer, after: :date_of_birth, default: 0
  end
end
