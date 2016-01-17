class CreateReceivedDocuments < ActiveRecord::Migration
  def change
    create_table :received_documents do |t|
      t.references :procedure, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.string :reference

      t.timestamps null: false
    end
    add_reference :verified_lists, :received_document, index: true
  end
end
