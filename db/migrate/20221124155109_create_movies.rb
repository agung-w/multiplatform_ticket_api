class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster_url
      t.string :tmdb_id
      t.decimal :vote_average
      t.string :airing_status
      t.timestamps
    end
  end
end
