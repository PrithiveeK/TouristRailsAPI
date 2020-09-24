class CreateBankDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_details do |t|
      t.string :beneficiary_name, null: false
      t.string :beneficiary_account_number
      t.string :beneficiary_address
      t.string :beneficiary_bank
      t.string :beneficiary_branch_name
      t.string :beneficiary_bank_address
      t.string :beneficiary_ifsc_code
      t.string :beneficiary_swift_code
      t.string :beneficiary_ibn_code
      t.boolean :is_verified
      t.string :beneficiary_bic_code
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
