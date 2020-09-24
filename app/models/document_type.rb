class DocumentType < ApplicationRecord
    has_many :company_tcs, dependent: :nullify
    validates :name, presence: true, uniqueness: true
end
