class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps null: false
    end
  end
end
