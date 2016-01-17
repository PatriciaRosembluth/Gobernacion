class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :canton
      t.string :province
      t.string :departament
      t.float :latitude
      t.float :longitude
      t.references :aop_type, index: true, foreign_key: true
      t.references :companty, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
