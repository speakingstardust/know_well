class CreateMeicoProducts < ActiveRecord::Migration
  def change
    create_table :meico_products do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
