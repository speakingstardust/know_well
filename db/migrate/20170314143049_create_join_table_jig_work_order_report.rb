class CreateJoinTableJigWorkOrderReport < ActiveRecord::Migration
  def change
    create_join_table :jig_work_orders, :reports do |t|
      # t.index [:jig_work_order_id, :report_id]
      # t.index [:report_id, :jig_work_order_id]
    end
  end
end
