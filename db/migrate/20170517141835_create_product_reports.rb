class CreateProductReports < ActiveRecord::Migration
  def change
    create_table :product_reports do |t|
      t.date :date_created
      t.text :note

      t.timestamps null: false
    end
  end
end
