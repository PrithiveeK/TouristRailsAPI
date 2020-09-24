class Language < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    before_save { language_iso_code.upcase! }
    before_save { name.capitalize! }
end
