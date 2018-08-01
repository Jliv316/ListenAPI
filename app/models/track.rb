class Track < ApplicationRecord
  belongs_to :artist
  belongs_to :album
  has_many :user_tracks
  has_many :users, through: :user_tracks
end
