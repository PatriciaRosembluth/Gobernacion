class Company < ActiveRecord::Base
	has_many :legal_agents, :dependent => :destroy
  	has_many :projects, :dependent => :destroy
  	before_validation :uppercase
	validates :name, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :name, length: {minimum:4, message:' debe tener como minimo cuatro caracteres'}
	validates :name, uniqueness: {message: ' ya existe, no se debe duplicar'}
	validates :principal_activity, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :nit, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :nit, uniqueness: {message: ' ya existe, no se debe duplicar'}
	validates :nit, numericality: { only_integer: true, message: ' debe ser un numero' }
	validates :address, :presence => {:message => ' no debe dejarse en blanco.'}
	validates :departament, :presence => {:message => ' no debe dejarse en blanco.'} 
	validates :phones, :presence => {:message => ' no debe dejarse en blanco.'} 
	validates :phones, numericality: { only_integer: true, message: ' debe ser un numero' }
	validates :email, allow_blank: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: 'presenta un formato invalido'}

	def self.search(search)
		where("name LIKE :search ", search:"%#{search}%")
	end

	def self.get_companies_with_legal_agents
		@companies = Array.new
		Company.all.each do |company|
			if company.legal_agents.any?
				@companies << [company.name, company.id]
			end
		end
		@companies
	end
	protected
	def uppercase
	  self.name = self.name.upcase
	end	
end
