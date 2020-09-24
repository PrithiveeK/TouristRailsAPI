class MasterChain < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end
