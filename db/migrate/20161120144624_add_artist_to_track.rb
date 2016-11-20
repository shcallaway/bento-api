class AddArtistToTrack < ActiveRecord::Migration[5.0]
  def change
    add_reference :tracks, :artist, foreign_key: :true
  end
end
