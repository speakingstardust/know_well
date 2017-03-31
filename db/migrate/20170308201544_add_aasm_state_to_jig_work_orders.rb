class AddAasmStateToJigWorkOrders < ActiveRecord::Migration
  def change
    add_column :jig_work_orders, :aasm_state, :string
  end
end
