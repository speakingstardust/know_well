class RemoveAddressFieldsFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :street_address, :string
    remove_column :customers, :city, :string
    remove_column :customers, :state, :string
    remove_column :customers, :zip, :string
  end
end
