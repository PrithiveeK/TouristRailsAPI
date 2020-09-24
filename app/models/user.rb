class User < ApplicationRecord
    has_secure_password
    belongs_to :company
    belongs_to :contact
    belongs_to :role
    belongs_to :title
    belongs_to :service_type
    belongs_to :department
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    before_save { email.downcase! }
end
