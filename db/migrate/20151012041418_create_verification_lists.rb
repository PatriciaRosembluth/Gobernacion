class CreateVerificationLists < ActiveRecord::Migration
  def change
    create_table :verification_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
