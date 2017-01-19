class AddReportToReportLineItems < ActiveRecord::Migration
  def change
    change_table :report_line_items do |t|
      t.belongs_to :report, index: true
    end
  end
end
