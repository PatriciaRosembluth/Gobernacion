class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if current_user.role == 1
      @documents = Document.all.paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @documents = Document.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
      else
        @documents = Document.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
      end
    else
      redirect_to root_url
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    #@verification_lists= Document.verification_lists
    Revision.delete_null_fields
  end

  # GET /documents/new
  def new
    @document = Document.new
    @verification_lists = VerificationList.all
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.typename= @document.typename.upcase
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'El documento fue registrado exitosamente' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'El documento fue actualizado exitosamente' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'El Documento fue eliminado' }
      format.json { head :no_content }
    end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:typename, revisions_attributes: [:id, :verification_list_id])
    end
end
