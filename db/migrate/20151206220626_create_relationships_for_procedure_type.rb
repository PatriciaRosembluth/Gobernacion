class CreateRelationshipsForProcedureType < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.belongs_to :procedure_type, index: true
      t.belongs_to :document, index: true
      t.timestamps null: false
    end
  end
end
