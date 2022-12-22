class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :additional_charge
    add_column :orders, :platform_fee, :decimal
    add_column :orders, :admin_fee, :decimal
  end
end
