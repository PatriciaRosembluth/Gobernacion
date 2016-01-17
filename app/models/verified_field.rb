class VerifiedField < ActiveRecord::Base
  belongs_to :verification_field
  belongs_to :verified_list

end
