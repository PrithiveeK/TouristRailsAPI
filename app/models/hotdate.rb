class Hotdate < ApplicationRecord
    belongs_to :hotdate_difficulty
    validates :name, presence: true
    validates :hotdate_difficulty_id, presence: true
end
