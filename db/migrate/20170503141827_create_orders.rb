class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date_created
      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
