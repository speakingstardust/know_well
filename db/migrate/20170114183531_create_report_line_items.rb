class CreateReportLineItems < ActiveRecord::Migration
  def change
    create_table :report_line_items do |t|

      t.integer :subtotal_cleaned
      t.integer :subtotal_repaired
      t.integer :total

      t.timestamps null: false
    end
  end
end
