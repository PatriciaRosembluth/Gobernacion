class CreateVerifiedFields < ActiveRecord::Migration
  def change
    create_table :verified_fields do |t|
      t.references :verification_field, index: true, foreign_key: true
      t.references :verification_list, index: true, foreign_key: true
      t.boolean :answer

      t.timestamps null: false
    end
  end
end
