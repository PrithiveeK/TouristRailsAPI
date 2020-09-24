class Title < ApplicationRecord
    has_many :users, dependent: :nullify
    validates :name, presence: true, uniqueness: true
    before_save { name.capitalize! }
end
