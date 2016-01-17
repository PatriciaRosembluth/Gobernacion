class VerifiedListsController < ApplicationController
  before_action :set_verified_list, only: [:show, :edit, :update, :destroy]
  before_action :verify_password_change

  # GET /verified_lists
  # GET /verified_lists.json
  def index
    @verified_lists = VerifiedList.all
  end

  # GET /verified_lists/1
  # GET /verified_lists/1.json
  def show
  end

  # GET /verified_lists/new
  def new
    @verified_list = VerifiedList.new
  end

  # GET /verified_lists/1/edit
  def edit
  end

  def create
    vl_id = params[:vl_id]
    received_document_id = params[:received_document_id]
    @verified_list = VerifiedList.create_verified_list(vl_id,received_document_id)
    redirect_to '/verified_lists/'+@verified_list.id.to_s+'/edit'
  end

  def verify
    @verified_list = VerifiedList.find(params[:id])
  end

  def update
    @verified_list.verified = true
    @verified_list.date_of_verification = Date.today
    @verified_list.save
    respond_to do |format|
      if @verified_list.update(verified_list_params)
        format.html { redirect_to @verified_list.received_document.procedure, notice: 'Se registraron cambios en lista verificada.' }
        format.json { render :show, status: :ok, location: @verified_list }
      else
        format.html { render :edit }
        format.json { render json: @verified_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verified_lists/1
  # DELETE /verified_lists/1.json
  def destroy
    @verified_list.destroy
    respond_to do |format|
      format.html { redirect_to verified_lists_url, notice: 'La lista fue eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verified_list
      @verified_list = VerifiedList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verified_list_params
      params.require(:verified_list).permit(:date_of_verification, verified_fields_attributes: [:answer,:id,:description])
    end
end
