class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|

      t.date :date_from
      t.date :date_to

      t.integer :total_cleaned
      t.integer :total_repaired

      t.float :cleaning_charge_total
      t.float :repair_charge_total
      t.float :charges_subtotal
      t.float :delivery_charge
      t.float :grand_total

      t.timestamps null: false
    end
  end
end
