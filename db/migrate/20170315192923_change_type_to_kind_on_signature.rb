class ChangeTypeToKindOnSignature < ActiveRecord::Migration
  def change
    change_table :signatures do |t|
      t.rename :type, :kind
    end 
  end
end
