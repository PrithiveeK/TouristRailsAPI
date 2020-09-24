class TermsAndCondition < ApplicationRecord
    has_many :company_tcs, dependent: :nullify
    belongs_to :from_market, :class_name => "Market"
    belongs_to :to_market, :class_name => "Market"
    validates :terms, presence: true
    validates :from_market_id, presence: true
    validates :to_market_id, presence: true
end
