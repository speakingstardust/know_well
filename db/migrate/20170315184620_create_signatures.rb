class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.string :name
      t.text :signature
      t.datetime :signed_on
      t.references :jig_work_order, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
