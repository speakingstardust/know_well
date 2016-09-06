class CreateJigs < ActiveRecord::Migration
  def change
    create_table :jigs do |t|
      t.string :name
      t.integer :cleaning_charge
      t.integer :repair_charge

      t.timestamps null: false
    end
  end
end
