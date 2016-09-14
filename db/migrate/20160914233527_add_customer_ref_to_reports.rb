class AddCustomerRefToReports < ActiveRecord::Migration
  def change
  	add_reference :reports, :customer, index: true, foreign_key: true
  end
end
