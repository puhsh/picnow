class AddAvatarFingerprintToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_fingerprint, :string
  end
end
