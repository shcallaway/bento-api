class Artist < ApplicationRecord
  # Each artist has many tracks.
  has_many :tracks

  # Each artist has many releases.
  has_many :releases

  # Validate fields.
  validates :name, uniqueness: true

  # It would be great if we could only run 
  # this when an artist is created from the
  # POST /tracks route. A regular presence: true
  # validation would be better for POST /artists,
  # as it does not rename the attribute.
  validate :name_presence

  private

  # Spit out a custom error if the name is blank.
  # (This resolves the issue of ambiguous field 'name'
  # in track creation errors. Tracks also have names.)
  def name_presence
    errors.add "artist", "can't be blank" if name == ""
  end
end
