class AddJigOrderLineItemIdToJigs < ActiveRecord::Migration
  def change
    add_column :jigs, :jig_order_line_item_id, :integer

    add_index :jigs, :jig_order_line_item_id
  end
end
