class CreateReportLineItems < ActiveRecord::Migration
  def change
    create_table :report_line_items do |t|

      t.integer :subtotal_cleaned
      t.integer :subtotal_repaired

      t.float :cleaning_charge_subtotal
      t.float :repair_charge_subtotal

      t.timestamps null: false
    end
  end
end
