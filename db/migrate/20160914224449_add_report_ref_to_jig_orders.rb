class AddReportRefToJigOrders < ActiveRecord::Migration
  def change
  	add_reference :jig_orders, :report, index: true, foreign_key: true
  end
end
