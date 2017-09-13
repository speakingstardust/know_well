class CreateScopeOfWorks < ActiveRecord::Migration
  def change
    create_table :scope_of_works do |t|
      t.string :name
      t.date :date_created
      t.string :created_by
      t.text :description

      t.timestamps null: false
    end
  end
end
