class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :manufacturer, index: true, foreign_key: true
      t.string :part_number
      t.references :vendor, index: true, foreign_key: true
      t.text :description
      t.string :container
      t.string :unit
      t.integer :units_per_container
      t.float :price_per_container
      t.float :price_per_unit
      t.float :maximum_on_hand
      t.float :minimum_on_hand
      t.integer :lead_time
      t.float :current_on_hand
      t.float :order_amount
      t.integer :category

      t.timestamps null: false
    end
  end
end
