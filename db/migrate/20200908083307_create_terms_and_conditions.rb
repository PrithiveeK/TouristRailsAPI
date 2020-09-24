class CreateTermsAndConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :terms_and_conditions do |t|
      t.string :terms, null: false
      t.references :from_market, null: false
      t.references :to_market, null: false
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end

    add_foreign_key :terms_and_conditions, :markets, column: :from_market_id, primary_key: :id
    add_foreign_key :terms_and_conditions, :markets, column: :to_market_id, primary_key: :id
  end
end
