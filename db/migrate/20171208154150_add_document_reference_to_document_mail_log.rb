class AddDocumentReferenceToDocumentMailLog < ActiveRecord::Migration
  def change
    change_table :document_mail_logs do |t|
      t.references :document, index: true, foreign_key: true
    end
  end
end
