class CreateSafetyDataSheets < ActiveRecord::Migration
  def change
    create_table :safety_data_sheets do |t|
      t.string :product_name
      t.string :manufacturer_name
      t.integer :category

      t.timestamps null: false
    end
  end
end
