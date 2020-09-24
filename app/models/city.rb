class City < ApplicationRecord
  has_many :contacts, dependent: :nullify
  belongs_to :country
  validates :name, presence: true, uniqueness: true
  validates :country_id, presence: true
end
