class AddCustomerIdToJigs < ActiveRecord::Migration
  def change
    add_column :jigs, :customer_id, :integer

    add_index :jigs, :customer_id
  end
end
