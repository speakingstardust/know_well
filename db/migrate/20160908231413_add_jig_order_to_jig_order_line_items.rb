class AddJigOrderToJigOrderLineItems < ActiveRecord::Migration
  def change
    add_column :jig_order_line_items, :jig_order_id, :integer

    add_index :jig_order_line_items, :jig_order_id
  end
end
