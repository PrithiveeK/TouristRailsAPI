class ServiceSupplierMapping < ApplicationRecord
    belongs_to :service
    belongs_to :supplier, :class_name => "Company"
end
