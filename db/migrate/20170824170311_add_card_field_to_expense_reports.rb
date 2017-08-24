class AddCardFieldToExpenseReports < ActiveRecord::Migration
  def change
    change_table :expense_reports do |t|
      t.integer :payment_method
    end
  end
end
