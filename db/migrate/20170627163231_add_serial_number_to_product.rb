class AddSerialNumberToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :serial_number
    end
  end
end
