class Chain < ApplicationRecord
    has_many :services, dependent: :nullify
    belongs_to :master_chain
    belongs_to :service_type
    validates :name, presence: true
    validates :master_chain_id, presence: true
end
