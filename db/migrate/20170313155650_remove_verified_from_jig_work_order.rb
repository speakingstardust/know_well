class RemoveVerifiedFromJigWorkOrder < ActiveRecord::Migration
  def change
    remove_column :jig_work_orders, :verified, :boolean
  end
end
