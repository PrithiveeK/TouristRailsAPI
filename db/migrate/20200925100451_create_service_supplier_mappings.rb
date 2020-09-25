class CreateServiceSupplierMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :service_supplier_mappings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :supplier, null: false
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end

    add_foreign_key :service_supplier_mappings, :companies, column: :supplier_id, primary_key: :id
  end
end
