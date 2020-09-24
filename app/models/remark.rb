class Remark < ApplicationRecord
    validates :name, presence: true
    before_save { remark_type.upcase! if remark_type }
end
