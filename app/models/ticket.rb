class Ticket < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end
