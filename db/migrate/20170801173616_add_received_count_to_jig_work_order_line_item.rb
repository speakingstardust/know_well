class AddReceivedCountToJigWorkOrderLineItem < ActiveRecord::Migration
  def change
    change_table :jig_work_order_line_items do |t|
      t.integer :received
    end
  end
end
