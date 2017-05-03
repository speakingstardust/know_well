class CreateOrderLineItems < ActiveRecord::Migration
  def change
    create_table :order_line_items do |t|
      t.references :product, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :amount_required
      t.timestamp :ordered_at
      t.timestamp :received_at

      t.timestamps null: false
    end
  end
end
