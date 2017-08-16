class CreateExpenseReports < ActiveRecord::Migration
  def change
    create_table :expense_reports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :admin, index: true, foreign_key: true
      t.date :date
      t.float :amount
      t.string :vendor
      t.integer :category
      t.text :note
      t.string :other

      t.timestamps null: false
    end
  end
end
