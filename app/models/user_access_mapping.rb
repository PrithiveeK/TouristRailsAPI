class UserAccessMapping < ApplicationRecord
  belongs_to :user
  belongs_to :access
end
