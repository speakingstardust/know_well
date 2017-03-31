class AddReturnTimeFieldToJigWorkOrder < ActiveRecord::Migration
  def change
    add_column :jig_work_orders, :return_time, :string
  end
end
