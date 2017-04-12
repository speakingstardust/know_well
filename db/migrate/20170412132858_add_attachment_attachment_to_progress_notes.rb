class AddAttachmentAttachmentToProgressNotes < ActiveRecord::Migration
  def self.up
    change_table :progress_notes do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :progress_notes, :attachment
  end
end
