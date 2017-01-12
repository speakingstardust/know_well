class AddJigPhotoToJigs < ActiveRecord::Migration
  def up
    add_attachment :jigs, :jig_photo
  end

  def down
    remove_attachment :jigs, :jig_photo
  end
end
