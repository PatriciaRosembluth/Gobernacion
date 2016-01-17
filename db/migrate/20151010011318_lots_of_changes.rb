class LotsOfChanges < ActiveRecord::Migration
  def change
      #aop_type
      drop_table :aop_types

      #company
      rename_column :companies, :canton, :zone
      rename_column :companies, :fax, :email
      remove_column :companies, :province
      remove_column :companies, :mailbox
      change_column :companies, :nit, :string

      #legal_agent
      remove_column :legal_agents, :identification_number
      remove_column :legal_agents, :identification_type
      remove_column :legal_agents, :first_name
      remove_column :legal_agents, :last_name
      remove_column :legal_agents, :country
      remove_column :legal_agents, :city
      remove_column :legal_agents, :address
      remove_column :legal_agents, :phone_number
      remove_column :legal_agents, :email
      remove_column :legal_agents, :mailbox
      remove_column :legal_agents, :user_id
      add_reference :legal_agents, :person, index: true, foreign_key: true

      #peolpe
      remove_column :people, :position
      remove_column :people, :profession
      rename_column :people, :firs_name, :first_name
      change_column :people, :identification_number, :string

      #project
      remove_column :projects, :canton
      remove_column :projects, :aop_type_id
      rename_column :projects, :province, :zone

      create_table :employee do |t|
        t.string :position
        t.string :profession
        t.string :agent_id
        t.references :person, index: true, foreign_key: true
        t.timestamps null: false
      end
  end
end
