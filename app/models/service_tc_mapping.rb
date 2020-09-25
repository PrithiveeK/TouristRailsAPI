class ServiceTcMapping < ApplicationRecord
  belongs_to :service
  belongs_to :tc, :calss_name => "TermsAndCondition"
end
