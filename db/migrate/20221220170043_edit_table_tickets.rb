class EditTableTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :movie_id, :integer
  end
end
