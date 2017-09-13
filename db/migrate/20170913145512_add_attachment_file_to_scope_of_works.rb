class AddAttachmentFileToScopeOfWorks < ActiveRecord::Migration
  def self.up
    change_table :scope_of_works do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :scope_of_works, :file
  end
end
