class AddCustomerToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :customer
    end

    add_index :addresses, :customer_id
  end
end
