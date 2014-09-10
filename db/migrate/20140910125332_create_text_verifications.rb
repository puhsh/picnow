class CreateTextVerifications < ActiveRecord::Migration
  def change
    create_table :text_verifications do |t|
      t.integer :user_id
      t.string :code
      t.datetime :confirmed_at, default: nil
      t.timestamps
    end

    add_index :text_verifications, :user_id, unique: true
  end
end
