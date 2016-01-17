class ReceivedDocument < ActiveRecord::Base
  belongs_to :procedure
  belongs_to :document
  has_many :verified_lists, :dependent => :destroy

  def has_all_lists_verified?
    verified_lists.each do |verified_list|
      unless verified_list.verified
        return false
      end
    end
    true
  end

  def create_verified_lists
    document.verification_lists.each do |verification_list|
      VerifiedList.create_verified_list(verification_list.id,self.id)
    end
  end
end
