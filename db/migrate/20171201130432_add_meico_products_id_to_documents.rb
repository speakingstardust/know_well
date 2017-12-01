class AddMeicoProductsIdToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :meico_product, foreign_key: true
  end
end
