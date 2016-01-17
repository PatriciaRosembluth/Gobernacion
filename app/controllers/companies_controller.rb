class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change
  before_action :verify_role

  # GET /companies
  # GET /companies.json
  def index
       if params[:search]
          @companies = Company.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
       else
          @companies = Company.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
       end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.name = @company.name.upcase
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Compania registrada exitosamente' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
      @company.name = @company.name.upcase
    respond_to do |format|
      if @company.update(company_params)
          format.html { redirect_to @company, notice: 'Compania actualizada exitosamente' }
          format.json { render :show, status: :ok, location: @company }
        else
          format.html { render :edit }
          format.json { render json: @company.errors, status: :unprocessable_entity }
       end 
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Compañia eliminada' }
      format.json { head :no_content }
    end
  end

  def verify_role
    if user_signed_in?
      if current_user.role==2 || current_user.role == 1 || current_user.role == 4
        [ :edit, :index, :new, :show]
      else
        redirect_to root_url
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :principal_activity, :nit, :address, :zone, :departament, :phones, :email,)
    end
end
