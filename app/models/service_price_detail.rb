class ServicePriceDetail < ApplicationRecord
    belongs_to :service
    belongs_to :room_type
    belongs_to :person_type
    belongs_to :charge_type
    belongs_to :menu_type
    belongs_to :breakfast_type
    belongs_to :category_type
end
