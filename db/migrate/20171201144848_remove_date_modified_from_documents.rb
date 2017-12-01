class RemoveDateModifiedFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :date_modified, :date
  end
end
