class CreateLinkedServicesMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :linked_services_mappings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :linked_service, null: false
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end

    add_foreign_key :linked_services_mappings, :services, column: :linked_service_id, primary_key: :id
  end
end
