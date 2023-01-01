class ModifyScheduleDataType < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :schedule
    remove_column :tickets, :schedule
    add_column(:orders, :schedule, :timestamp)
    add_column(:tickets, :schedule, :timestamp)
  end
end
