class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.string :website
      t.string :phone

      t.timestamps null: false
    end
  end
end
