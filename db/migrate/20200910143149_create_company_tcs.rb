class CreateCompanyTcs < ActiveRecord::Migration[6.0]
  def change
    create_table :company_tcs do |t|
      t.references :company, null: false, foreign_key: true
      t.string :subject
      t.references :tc, null: false
      t.integer :order_id, null: false
      t.references :document_type, null: false, foreign_key: true
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end

    add_foreign_key :company_tcs, :terms_and_conditions, column: :tc_id, primary_key: :id
  end
end
