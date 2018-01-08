class AddEmailAndOthersToCustomer < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.string :customer_service_email
      t.string :website
      t.string :invoice_email
      t.integer :payment
    end
  end
end
