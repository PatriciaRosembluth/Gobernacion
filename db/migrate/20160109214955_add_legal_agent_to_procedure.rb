class AddLegalAgentToProcedure < ActiveRecord::Migration
  def change
    add_reference :procedures, :legal_agent , index: true
  end
end
