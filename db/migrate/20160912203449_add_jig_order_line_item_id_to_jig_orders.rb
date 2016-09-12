class AddJigOrderLineItemIdToJigOrders < ActiveRecord::Migration
  def change
    add_column :jig_orders, :jig_order_line_item_id, :integer
    add_index :jig_orders, :jig_order_line_item_id
  end
end
