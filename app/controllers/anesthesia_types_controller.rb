class AnesthesiaTypesController < ApplicationController
  authorize_resource
  before_action :set_anesthesia_type, only: [:show, :edit, :update, :destroy]

  # GET /anesthesia_types
  # GET /anesthesia_types.json
  def index
    @anesthesia_types = AnesthesiaType.all
  end

  # GET /anesthesia_types/1
  # GET /anesthesia_types/1.json
  def show
  end

  # GET /anesthesia_types/new
  def new
    @anesthesia_type = AnesthesiaType.new
  end

  # GET /anesthesia_types/1/edit
  def edit
  end

  # POST /anesthesia_types
  # POST /anesthesia_types.json
  def create
    @anesthesia_type = AnesthesiaType.new(anesthesia_type_params)

    respond_to do |format|
      if @anesthesia_type.save
        format.html { redirect_to anesthesia_types_path, notice: 'Anesthesia type was successfully created.' }
        format.json { render :show, status: :created, location: @anesthesia_type }
      else
        format.html { render :new }
        format.json { render json: @anesthesia_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anesthesia_types/1
  # PATCH/PUT /anesthesia_types/1.json
  def update
    respond_to do |format|
      if @anesthesia_type.update(anesthesia_type_params)
        format.html { redirect_to anesthesia_types_path, notice: 'Anesthesia type was successfully updated.' }
        format.json { render :show, status: :ok, location: @anesthesia_type }
      else
        format.html { render :edit }
        format.json { render json: @anesthesia_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anesthesia_types/1
  # DELETE /anesthesia_types/1.json
  def destroy
    @anesthesia_type.destroy
    respond_to do |format|
      format.html { redirect_to anesthesia_types_url, notice: 'Anesthesia type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anesthesia_type
      @anesthesia_type = AnesthesiaType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anesthesia_type_params
      params.require(:anesthesia_type).permit(:name, :description)
    end
end
