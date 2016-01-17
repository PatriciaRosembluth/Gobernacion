class AddProctypeRefToProcNdVeriflist < ActiveRecord::Migration
  def change
    add_reference :procedures, :procedure_type, index:true
    add_reference :verification_lists, :procedure_type, index:true
  end
end
