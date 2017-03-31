class ChangePickupToDateOnlyAndTimeToString < ActiveRecord::Migration
  def up
    change_table :jig_work_orders do |t|
      t.remove :pickup
      t.date :pickup_date
      t.string :pickup_time
    end
  end

  def down
    change_table :jig_work_orders do |t|
      t.remove :pickup_date, :pickup_time
      t.datetime :pickup
    end
  end
end
