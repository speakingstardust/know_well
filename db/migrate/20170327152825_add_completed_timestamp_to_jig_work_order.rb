class AddCompletedTimestampToJigWorkOrder < ActiveRecord::Migration
  def change
    add_column :jig_work_orders, :completed_at, :datetime
    add_column :jig_work_orders, :completed_by, :string
  end
end
