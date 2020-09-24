class MenuType < ApplicationRecord
    has_many :price_details, dependent: :nullify
    validates :name, presence: true, uniqueness: true
end
