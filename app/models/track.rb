class Track < ApplicationRecord
  # Each track belongs to an artist.
  belongs_to :artist

  # Mount the TrackUploader to the file attribute.
  mount_uploader :file, TrackUploader

  # Validate fields.
  validate :max_file_size
  validates :name, :artist, :release, :file, presence: true

  private

  # Add an error if file is larger than limit.
  def max_file_size
    errors.add :file, "exceeds maximum size" if file.size > 10.megabytes
  end
end
