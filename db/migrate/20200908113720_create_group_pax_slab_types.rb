class CreateGroupPaxSlabTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :group_pax_slab_types do |t|
      t.integer :pax_slab, null: false
      t.integer :foc, null: false
      t.integer :sgl
      t.integer :half_twin
      t.string :description
      t.string :status, :default => 'ACTIVE'

      t.timestamps
    end
  end
end
