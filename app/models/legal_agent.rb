class LegalAgent < ActiveRecord::Base
		belongs_to :person, :dependent => :destroy
		belongs_to :company
		has_many :procedures, :dependent => :destroy

		def self.search(search)
			where('first_name LIKE :search OR last_name LIKE :search', search:"%#{search}%")
		end


end
