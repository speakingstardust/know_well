class AddAttachmentPdfToSafetyDataSheets < ActiveRecord::Migration
  def self.up
    change_table :safety_data_sheets do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :safety_data_sheets, :pdf
  end
end
