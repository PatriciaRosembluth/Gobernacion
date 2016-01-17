class MakeReplationshipForDocumentsAndVerificationList < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.belongs_to :document, index: true
      t.belongs_to :verification_list, index: true
      t.timestamps null: false
    end
  end
end
