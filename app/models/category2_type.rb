class Category2Type < ApplicationRecord
  belongs_to :service_type
  validates :name, presence: true, uniqueness: true
  validates :service_type, presence: true
end
