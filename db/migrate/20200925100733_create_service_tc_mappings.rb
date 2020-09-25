class CreateServiceTcMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :service_tc_mappings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :tc, null: false
      t.string :status, :default => 'ACTIVE'
      
      t.timestamps
    end

    add_foreign_key :service_tc_mappings, :terms_and_conditions, column: :tc_id, primary_key: :id
  end
end
