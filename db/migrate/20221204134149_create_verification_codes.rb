class CreateVerificationCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_codes do |t|
      t.references :user, null: false, foreign_key: true
      t.text :phone_number , index:true
      t.string :code
      t.timestamp :expire_at
      t.timestamps
    end
  end
end
