class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :release
end
