class CreateJigWorkOrderLineItems < ActiveRecord::Migration
  def change
    create_table :jig_work_order_line_items do |t|
      t.references :jig, index: true, foreign_key: true
      t.references :jig_work_order, index: true, foreign_key: true
      t.integer :expected
      t.integer :repaired
      t.integer :actual

      t.timestamps null: false
    end
  end
end
