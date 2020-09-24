class ServiceType < ApplicationRecord
    has_many :category_types
    has_many :category2_types
    has_many :amenities
    has_many :facilities
    has_many :addons
    has_many :chains, dependent: :nullify
    has_many :companies, dependent: :nullify
    has_many :users, dependent: :nullify
    validates :name, presence: true, uniqueness: true
end
