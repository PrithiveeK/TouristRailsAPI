class ClassType < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end
