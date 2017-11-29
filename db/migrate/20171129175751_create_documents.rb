class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :type
      t.string :version
      t.date :date_issued
      t.string :created_by
      t.date :date_modified
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
