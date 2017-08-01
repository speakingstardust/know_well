class AddReceivedCountToJigWorkOrderLineItem < ActiveRecord::Migration
  def change
    change_table :jig_work_order_line_items do |t|
      t.number :received
    end
  end
end
