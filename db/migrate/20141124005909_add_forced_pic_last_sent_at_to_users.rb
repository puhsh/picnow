class AddForcedPicLastSentAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forced_pic_last_sent_at, :datetime
  end
end
