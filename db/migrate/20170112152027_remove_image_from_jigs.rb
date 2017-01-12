class RemoveImageFromJigs < ActiveRecord::Migration
  def up
    remove_column :jigs, :image
  end

  def down
    add_column :jigs, :image, :string
  end
end
