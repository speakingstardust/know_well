class CreateJigOrderLineItems < ActiveRecord::Migration
  def change
    create_table :jig_order_line_items do |t|
      t.integer :repaired
      t.integer :cleaned
      t.integer :jig_id

      t.timestamps null: false
    end
    add_index :jig_order_line_items, :jig_id
  end
end
