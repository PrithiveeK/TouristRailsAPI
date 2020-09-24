class Company < ApplicationRecord
    belongs_to :contact
    belongs_to :company_type
    belongs_to :bank_detail
    belongs_to :service_type
    has_many :users, dependent: :nullify
    has_many :company_tcs, dependent: :nullify
end
