class CreateJoinTableJigOrdersReports < ActiveRecord::Migration
  def change
    create_join_table :jig_orders, :reports do |t|
      t.index [:jig_order_id, :report_id]
      t.index [:report_id, :jig_order_id]
    end
  end
end
