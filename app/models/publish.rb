class Publish < ApplicationRecord
  
  belongs_to :user
  has_many :passengers
  has_many :users, through: :passengers

  scope :within_radius, ->(source_latitude, source_longitude, source_radius, destination_latitude, destination_longitude, destination_radius) {
    where("ST_DWithin(ST_MakePoint(publishes.source_longitude, publishes.source_latitude)::geography, ST_MakePoint(?, ?)::geography, ?)
           AND ST_DWithin(ST_MakePoint(publishes.destination_longitude, publishes.destination_latitude)::geography, ST_MakePoint(?, ?)::geography, ?)",
           source_longitude, source_latitude, source_radius * 1000,
           destination_longitude, destination_latitude, destination_radius * 1000)
  }





end