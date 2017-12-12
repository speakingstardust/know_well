class AddCurrentVersionFlagToDocument < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.boolean :current_version
    end
  end
end
