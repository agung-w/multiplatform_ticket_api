class ModifyMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :vote_average, :decimal
    add_column :movies, :airing_status, :string
  end
end
