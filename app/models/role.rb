class Role < ApplicationRecord
    has_many :roles_accesses_mappings
    has_many :users, dependent: :nullify
    validates :name, presence: true, uniqueness: true
end
