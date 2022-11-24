class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :reset_password_token
      t.timestamp :reset_password_at

      t.timestamps
    end
  end
end
