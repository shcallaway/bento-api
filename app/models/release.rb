class Release < ApplicationRecord
  # Each release belongs to an artist.
  belongs_to :artist
  validates :name, presence: :true
end
