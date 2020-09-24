class CoachSizeType < ApplicationRecord
    validates :coach_size,  presence: true, uniqueness: true
end
