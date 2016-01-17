class User < ActiveRecord::Base
  before_save :verify_password
  # devise :timeoutable, :timeout_in => 10.minutes

  has_one :person
  has_many :procedures, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  # validates :email, format:{ :multiline => true, with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: 'no tiene formato invalido'}
  #validates :username, :presence => {:message => 'no debe dejarse en blanco'}
  validates :username, :uniqueness => {:message => 'ya fue registrado, no debe repetirse'}
  #validates :username, length: {minimum: 5, :message => 'no debe tener menos de 5 caracteres.'}
  #validates :username, length: {maximum: 25, :message => 'no debe tener mas de 25 caracteres.'}
  validates :password, length: {minimum:8, :message => 'debe tener minimamente ocho caracteres' }

  def self.find_for_database_authentication(conditions={})
    find_by(username: conditions[:login])
  end

  def self.search(search)
    where("username LIKE ?", "%#{search}%")
  end

  search = 'admin'
  User.where('username LIKE ?', "#{search}[0-9][0-9][0-9][0-9]")

  def current_procedures_assigned
    if role==5
      return '('+Procedure.where(state:2,user_id: self.id).count.to_s+')'
    else
      return '(-)'
    end
  end

  def verify_password
    if changed.include?('encrypted_password') && self.sign_in_count != 0
      self.password_alteration = 1
    end
  end

end
