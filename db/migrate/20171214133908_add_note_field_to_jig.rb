class AddNoteFieldToJig < ActiveRecord::Migration
  def change
    change_table :jigs do |t|
      t.text :note
    end
  end
end
