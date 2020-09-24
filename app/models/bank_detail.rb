class BankDetail < ApplicationRecord
    has_one :company, dependent: :nullify
    validates :beneficiary_name, presence: true
end
