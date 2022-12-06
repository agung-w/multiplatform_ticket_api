class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :order, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :transaction_type
      t.string :transaction_method
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
