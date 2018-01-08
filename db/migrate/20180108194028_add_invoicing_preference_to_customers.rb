class AddInvoicingPreferenceToCustomers < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.boolean :mail_invoice
    end
  end
end
