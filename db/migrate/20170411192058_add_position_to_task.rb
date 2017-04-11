class AddPositionToTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :order, :integer
    add_column :tasks, :position, :integer
  end
end
