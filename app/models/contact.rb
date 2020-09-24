class Contact < ApplicationRecord
    has_one :company
    has_many :users, dependent: :nullify
    belongs_to :country
    belongs_to :city
end
