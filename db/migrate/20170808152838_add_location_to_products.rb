class AddLocationToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :location
    end
  end
end
