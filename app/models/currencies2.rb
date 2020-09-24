class Currencies2 < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    before_save { name.upcase! }
end
