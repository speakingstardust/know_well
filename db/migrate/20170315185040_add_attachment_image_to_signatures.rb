class AddAttachmentImageToSignatures < ActiveRecord::Migration
  def self.up
    change_table :signatures do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :signatures, :image
  end
end
