class ServiceCategoryMapping < ApplicationRecord
    belongs_to :service
    belongs_to :category_type
end
