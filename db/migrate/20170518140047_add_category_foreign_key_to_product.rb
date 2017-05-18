class AddCategoryForeignKeyToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :category, index: true, foreign_key: true
    end
  end
end
