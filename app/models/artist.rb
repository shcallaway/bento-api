class Artist < ApplicationRecord
  # Each artist has many tracks.
  has_many :tracks

  # Validate fields.
  validates :name, presence: :true, uniqueness: true
end
