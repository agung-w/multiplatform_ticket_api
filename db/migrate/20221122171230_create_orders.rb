class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.integer :movie_id
      t.references :user, null: false, foreign_key: true
      t.references :studio, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :sub_total
      t.decimal :additional_charge
      t.decimal :discount
      t.string :status

      t.timestamps
    end
    add_index :orders, :movie_id
  end
end
