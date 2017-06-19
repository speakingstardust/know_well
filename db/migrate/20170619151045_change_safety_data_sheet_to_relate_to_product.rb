class ChangeSafetyDataSheetToRelateToProduct < ActiveRecord::Migration
  def change
    change_table :safety_data_sheets do |t|
      t.belongs_to :product, index: true
    end
    remove_column :safety_data_sheets, :product_name, :string
    remove_column :safety_data_sheets, :manufacturer_name, :string
    remove_column :safety_data_sheets, :category, :integer
  end
end
