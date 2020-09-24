class CreateRemarks < ActiveRecord::Migration[6.0]
  def change
    create_table :remarks do |t|
      t.string :name, null: false
      t.string :remark_type, :default => 'STATIC'
      t.string :select_type
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
