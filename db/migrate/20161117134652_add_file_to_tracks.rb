class AddFileToTracks < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :file, :string
  end
end
