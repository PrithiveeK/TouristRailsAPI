class BreakfastType < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :price_details, dependent: :nullify
    before_save { name.upcase! }
end
