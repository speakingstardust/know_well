class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.string :name
      t.text :description
      t.boolean :completed
      t.references :user, index: true, foreign_key: true
      t.integer :percent_complete

      t.timestamps null: false
    end
  end
end
