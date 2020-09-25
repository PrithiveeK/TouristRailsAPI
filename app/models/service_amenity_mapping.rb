class ServiceAmenityMapping < ApplicationRecord
    belongs_to :service
    belongs_to :amenity
end
