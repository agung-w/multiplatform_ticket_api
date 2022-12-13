class AddBrandToCinemas < ActiveRecord::Migration[7.0]
  def change
    add_column :cinemas, :brand, :string
  end
end
