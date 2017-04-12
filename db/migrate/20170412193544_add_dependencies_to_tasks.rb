class AddDependenciesToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :dependent, index: true
    end
  end
end
