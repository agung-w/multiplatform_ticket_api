class AddPriceToStudio < ActiveRecord::Migration[7.0]
  def change
    add_column :studios, :price, :decimal
  end
end
