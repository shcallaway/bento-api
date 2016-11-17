class Track < ApplicationRecord
  # Mount the TrackUploader to the file attribute.
  mount_uploader :file, TrackUploader

  # Validate fields.
  validate :file_size
  validates :name, :file, :artist, :release, presence: true

  private

  # Add an error if file is larger than limit.
  def file_size
    errors.add :file, "exceeds maximum size" if file.size > 10.megabytes
  end
end
