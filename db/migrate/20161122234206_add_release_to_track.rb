class AddReleaseToTrack < ActiveRecord::Migration[5.0]
  def change
    add_reference :tracks, :release, foreign_key: :true
  end
end