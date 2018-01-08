class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :fax
      t.integer :kind
      t.text :note

      t.timestamps null: false
    end
  end
end
