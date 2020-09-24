class Service < ApplicationRecord
    belongs_to :service_type
    belongs_to :country
    belongs_to :city
    belongs_to :chain
    belongs_to :location_type
    belongs_to :location2_type
    belongs_to :style
    has_many :price_details, dependent: :nullify
end
