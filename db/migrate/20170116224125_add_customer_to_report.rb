class AddCustomerToReport < ActiveRecord::Migration
  def change
    change_table :reports do |t|
      t.belongs_to :customer, index: true
    end
  end
end
