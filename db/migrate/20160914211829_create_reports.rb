class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
    	t.date :start_date 
    	t.date :end_date
    	t.float :delivery_charge

      t.timestamps null: false
    end
  end
end
