class AddArtistToRelease < ActiveRecord::Migration[5.0]
  def change
    add_reference :releases, :artist, foreign_key: :true
  end
end
