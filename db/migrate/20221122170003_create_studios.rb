class CreateStudios < ActiveRecord::Migration[7.0]
  def change
    create_table :studios do |t|
      t.references :cinema, null: false, foreign_key: true
      t.string :code
      t.integer :capacity

      t.timestamps
    end
  end
end
