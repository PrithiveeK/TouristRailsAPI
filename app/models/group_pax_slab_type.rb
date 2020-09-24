class GroupPaxSlabType < ApplicationRecord
    validates :pax_slab, presence: true
    validates :foc, presence: true
end
