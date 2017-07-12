class AddProjectToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :project
    end 
    add_index :comments, :project_id
  end
end
