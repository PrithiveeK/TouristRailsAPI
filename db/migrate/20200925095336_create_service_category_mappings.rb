class CreateServiceCategoryMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :service_category_mappings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :category_type, null: false, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
