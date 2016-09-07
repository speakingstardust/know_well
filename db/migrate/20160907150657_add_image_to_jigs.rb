class AddImageToJigs < ActiveRecord::Migration
  def change
    add_column :jigs, :image, :string
  end
end
