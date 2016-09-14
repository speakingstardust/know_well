class ChangeJigChargesToFloat < ActiveRecord::Migration
  def change
  	change_column :jigs, :cleaning_charge, :float
  	change_column :jigs, :repair_charge, :float
  end
end
