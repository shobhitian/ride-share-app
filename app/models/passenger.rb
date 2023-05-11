class Passenger < ApplicationRecord
  belongs_to :user
  belongs_to :publish
end
