class AddColumnToStudio < ActiveRecord::Migration[7.0]
  def change
    add_column :studios, :row, :integer
    add_column :studios, :column, :integer
  end
end
