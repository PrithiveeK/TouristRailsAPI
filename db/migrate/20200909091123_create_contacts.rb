class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :country
      t.references :city
      t.string :zipcode
      t.string :fax
      t.string :phone_no
      t.string :telephone_no
      t.string :email
      t.string :address_line_1
      t.string :address_line_2
      t.string :street
      t.string :skype_id
      t.string :website
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
