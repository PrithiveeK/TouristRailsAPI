class Amenity < ApplicationRecord
  belongs_to :service_type
  validates :name, presence: true, uniqueness: true
  validates :service_type_id, presence: true
end
