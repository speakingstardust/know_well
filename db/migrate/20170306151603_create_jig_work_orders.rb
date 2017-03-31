class CreateJigWorkOrders < ActiveRecord::Migration
  def change
    create_table :jig_work_orders do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :purchase_order
      t.text :notes
      t.datetime :pickup
      t.date :returned
      t.boolean :verified
      t.string :verified_by
      t.datetime :verified_at

      t.timestamps null: false
    end
  end
end
