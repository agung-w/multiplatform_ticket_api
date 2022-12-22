class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :order_id
      t.integer :user_id
      t.integer :cinema_id
      t.integer :studio_id
      t.string :schedule
      t.string :seat

      t.timestamps
    end
  end
end
