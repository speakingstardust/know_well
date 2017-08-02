class AddDriverAndTruckNumberToJigWorkOrder < ActiveRecord::Migration
  def change
    change_table :jig_work_orders do |t|
      t.string :driver
      t.string :truck_number
    end
  end
end
