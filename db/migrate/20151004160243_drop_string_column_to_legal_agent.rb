class DropStringColumnToLegalAgent < ActiveRecord::Migration
  def change
  	remove_column :legal_agents, :string
  end
end
