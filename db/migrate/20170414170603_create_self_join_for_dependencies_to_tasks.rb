class CreateSelfJoinForDependenciesToTasks < ActiveRecord::Migration
  def up
    create_table :dependencies, id: false do |t|
      t.integer :task_id
      t.integer :dependent_task_id
    end

    add_index :dependencies, [:dependent_task_id, :task_id], unique: true
    add_index :dependencies, [:task_id, :dependent_task_id], unique: true
  end

  def down
    remove_index :dependencies, [:dependent_task_id, :task_id] 
    remove_index :dependencies, [:task_id, :dependent_task_id] 
    drop_table :dependencies
  end
end
