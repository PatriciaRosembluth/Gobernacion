class CreateVerificationFields < ActiveRecord::Migration
  def change
    create_table :verification_fields do |t|
      t.string :description
      t.references :verification_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
