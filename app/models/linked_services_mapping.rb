class LinkedServicesMapping < ApplicationRecord
    belongs_to :service
    belongs_to :linked_service, :class_name => "Service"
end
