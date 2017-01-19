class CreateJoinTableJigOrderLineItemReportLineItem < ActiveRecord::Migration
  def change
    create_join_table :jig_order_line_items, :report_line_items do |t|
      t.index [:jig_order_line_item_id, :report_line_item_id], name: 'joli_rli_index'
      t.index [:report_line_item_id, :jig_order_line_item_id], name: 'rli_joli_index'
    end
  end
end
