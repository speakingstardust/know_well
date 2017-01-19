class AddJigtoReportLineItem < ActiveRecord::Migration
  def change
    change_table :report_line_items do |t|
      t.belongs_to :jig, index: true
    end
  end
end
