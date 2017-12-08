class CreateDocumentMailLogs < ActiveRecord::Migration
  def change
    create_table :document_mail_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :admin, index: true, foreign_key: true
      t.text :purpose
      t.datetime :sent_at
      t.references :customer, index: true, foreign_key: true
      t.string :email

      t.timestamps null: false
    end
  end
end
