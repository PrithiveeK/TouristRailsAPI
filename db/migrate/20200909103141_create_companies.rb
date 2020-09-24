class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :company_type, null: false, foreign_key: true
      t.references :service_type, foreign_key: true
      t.references :contact, null: false, foreign_key: true
      t.references :bank_detail, foreign_key: true
      t.string :currency
      t.date :date_of_establishment
      t.integer :parent_id
      t.boolean :is_sister_company, :default => false
      t.string :markup_type
      t.decimal :markup_value, precision: 5, scale: 2
      t.string :logo_url
      t.string :local_name
      t.string :status, :default => 'ACTIVE'
      t.string :code
      t.boolean :is_preferred      

      t.timestamps
    end
  end
end
