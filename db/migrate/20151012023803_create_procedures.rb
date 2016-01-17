class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.integer :state
      t.date :start_date
      t.date :end_date
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
