class CategoryType < ApplicationRecord
    has_many :price_details, dependent: :nullify
    belongs_to :service_type
  validates :name, presence: true, uniqueness: true
  validates :service_type, presence: true
end
