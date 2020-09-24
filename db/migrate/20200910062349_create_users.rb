class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :sur_name
      t.string :designation
      t.string :middle_name
      t.string :last_name
      t.string :local_name
      t.string :email, null: false, :unique => true
      t.string :password_digest, null: false
      t.string :phone
      t.references :company, foreign_key: true
      t.references :contact, foreign_key: true
      t.references :role, foreign_key: true
      t.date :date_of_joining
      t.date :date_of_birth
      t.date :anniversary_date
      t.boolean :is_preffered_contact
      t.references :department, foreign_key: true
      t.references :title, foreign_key: true
      t.references :service_type, foreign_key: true
      t.string :status, :default => 'ACTIVE'
      t.string :code

      t.timestamps
    end
  end
end
