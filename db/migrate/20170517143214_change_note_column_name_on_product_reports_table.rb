class ChangeNoteColumnNameOnProductReportsTable < ActiveRecord::Migration
  def change
    rename_column :product_reports, :note, :notes
  end
end
