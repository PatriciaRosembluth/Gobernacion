class ListCategory < ActiveRecord::Base
  has_many :verification_lists, :dependent => :destroy

  validates :name, presence: {message:'no debe dejarse en blanco'}
  validates :name, uniqueness: {message: 'ya existe, no se debe repetir'}

end
