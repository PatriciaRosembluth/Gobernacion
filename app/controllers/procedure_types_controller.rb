class ProcedureTypesController < ApplicationController
  before_action :set_procedure_type, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change
  before_action :verify_role
  before_action :delete_null_fields

  def delete_null_fields
    Requirement.delete_null_fields
  end

  # GET /procedure_types
  # GET /procedure_types.json
  def index
    @procedure_types = ProcedureType.all.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
      @procedure_types = ProcedureType.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    else
      @procedure_types = ProcedureType.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @count = @procedure_type.requirements.count
  end

  # GET /procedure_types/new
  def new
    @procedure_type = ProcedureType.new
    @documents = Document.all
  end

  # GET /procedure_types/1/edit
  def edit
    @documents = Document.all
    @count = @procedure_type.requirements.count
  end

  # POST /procedure_types
  # POST /procedure_types.json
  def create
    @procedure_type = ProcedureType.new(procedure_type_params)
    @documents = Document.all
    @procedure_type.name= @procedure_type.name.upcase
    respond_to do |format|
      if @procedure_type.save
        format.html { redirect_to procedure_types_path, notice: 'Tipo de tramite registrado exitosamente' }
        format.json { render :show, status: :created, location: @procedure_type }
      else
        format.html { render :new }
        format.json { render json: @procedure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedure_types/1
  # PATCH/PUT /procedure_types/1.json
  def update
    @count = @procedure_type.requirements.count
    respond_to do |format|
      if @procedure_type.update(procedure_type_params)
        format.html { redirect_to procedure_types_path, notice: 'Tipo de tramite actualizado exitosamente' }
        format.json { render :show, status: :ok, location: @procedure_type }
      else
        format.html { render :edit }
        format.json { render json: @procedure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procedure_types/1
  # DELETE /procedure_types/1.json
  def destroy
    @procedure_type.destroy
    respond_to do |format|
      format.html { redirect_to procedure_types_url, notice: 'Tipo de tramite eliminado exitosamente' }
      format.json { head :no_content }
    end
  end

  def verify_role
  if user_signed_in?
    if current_user.role==1  || current_user.role == 2
      [ :edit, :index, :new, :show, :create]
    else
      redirect_to root_url
    end
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure_type
      @procedure_type = ProcedureType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_type_params
      params.require(:procedure_type).permit(:name ,requirements_attributes: [:id,:document_id])
    end
end
