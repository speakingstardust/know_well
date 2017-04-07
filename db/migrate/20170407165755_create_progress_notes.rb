class CreateProgressNotes < ActiveRecord::Migration
  def change
    create_table :progress_notes do |t|
      t.references :project, index: true, foreign_key: true
      t.text :note
      t.string :created_by

      t.timestamps null: false
    end
  end
end
