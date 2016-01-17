class CreateAopTypes < ActiveRecord::Migration
  def change
    create_table :aop_types do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
