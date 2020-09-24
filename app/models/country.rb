class Country < ApplicationRecord
  has_many :cities
  has_many :contacts, dependent: :nullify
  belongs_to :continent
  validates :name, presence: true, uniqueness: true
  validates :continent_id, presence: true
  before_save :changeCase

  def changeCase
    self.name.capitalize!
    self.iso_code.upcase! if self.iso_code
    self.isd_code.upcase! if self.isd_code
  end
end
