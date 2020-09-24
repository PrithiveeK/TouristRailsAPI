class Region < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    before_save { name.capitalize! }
end
