class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :release, :file

  # Override the file attribute serializer
  # to produce better formatted JSON.
  def file
    object.file.url
  end
end
