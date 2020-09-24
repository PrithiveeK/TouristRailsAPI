class AddServiceTypeToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :service_type_id, :integer
    add_reference :companies, :service_type, foreign_key: true
  end
end
