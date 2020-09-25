class ServiceTcMapping < ApplicationRecord
  belongs_to :service
  belongs_to :tc, :class_name => "TermsAndCondition"
end
