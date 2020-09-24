class ChargeType < ApplicationRecord
    has_many :price_details, dependent: :nullify
    validates :name, presence: true, uniqueness: true
    before_save { name.upcase! }
end
