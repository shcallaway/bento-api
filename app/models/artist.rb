class Artist < ApplicationRecord
  has_many :tracks
  validates :name, presence: :true, uniqueness: true
end
