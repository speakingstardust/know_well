class CreateJigOrders < ActiveRecord::Migration
  def change
    create_table :jig_orders do |t|
      t.date :date
      t.integer :customer_id
      t.text :notes

      t.timestamps null: false
    end

    add_index :jig_orders, :customer_id
  end
end
