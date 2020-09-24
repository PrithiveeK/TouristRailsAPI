class Style < ApplicationRecord
    has_many :services, dependent: :nullify
    validates :name, presence: true, uniqueness: true
    before_save { name.capitalize! }
end
