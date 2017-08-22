class RemoveOtherFieldAndAddOtherNoteFieldFromExpenseReport < ActiveRecord::Migration
  def up
    change_table :expense_reports do |t|
      t.remove :other
      t.string :other_note
    end
  end

  def down
    change_table :expense_reports do |t|
      t.string :other
      t.remove :other_note
    end
  end
end
