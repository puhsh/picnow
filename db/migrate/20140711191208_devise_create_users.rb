class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username,           null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :phone_number,       null: false, default: ""
      t.datetime :date_of_birth,    null: false
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :username,             unique: true
    add_index :users, :email,                unique: true
    add_index :users, :phone_number,         unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
