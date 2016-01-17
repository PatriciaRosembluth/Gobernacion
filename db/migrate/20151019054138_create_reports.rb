class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :antecedent
      t.text :description
      t.text :conclusion
      t.text :recommendation
      t.references :Procedure, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
