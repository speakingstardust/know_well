class AddAkaToJigs < ActiveRecord::Migration
  def change
    change_table :jigs do |t|
      t.text :aka
    end
  end
end
