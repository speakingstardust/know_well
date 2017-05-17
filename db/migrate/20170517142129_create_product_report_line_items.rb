class CreateProductReportLineItems < ActiveRecord::Migration
  def change
    create_table :product_report_line_items do |t|
      t.references :product_report, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.float :current_amount

      t.timestamps null: false
    end
  end
end
