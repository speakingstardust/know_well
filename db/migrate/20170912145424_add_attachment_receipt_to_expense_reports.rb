class AddAttachmentReceiptToExpenseReports < ActiveRecord::Migration
  def self.up
    change_table :expense_reports do |t|
      t.attachment :receipt
    end
  end

  def self.down
    remove_attachment :expense_reports, :receipt
  end
end
