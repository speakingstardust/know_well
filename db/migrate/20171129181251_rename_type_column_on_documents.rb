class RenameTypeColumnOnDocuments < ActiveRecord::Migration
  def change
    rename_column :documents, :type, :category
  end
end
