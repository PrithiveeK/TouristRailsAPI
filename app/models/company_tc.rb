class CompanyTc < ApplicationRecord
    belongs_to :company
    belongs_to :document_type
    belongs_to :tc, :class_name => 'TermsAndCondition'
end
