class RemoveAdminFieldFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean, default: false
  end
end
