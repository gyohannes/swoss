class AnesthesiansController < ApplicationController
  before_action :set_anesthesian, only: [:show, :edit, :update, :destroy]

  # GET /anesthesians
  # GET /anesthesians.json
  def index
    @anesthesians = Anesthesian.all
  end

  # GET /anesthesians/1
  # GET /anesthesians/1.json
  def show
  end

  # GET /anesthesians/new
  def new
    @anesthesian = Anesthesian.new
    @anesthesian.hospital_id = current_user.hospital_id
  end

  # GET /anesthesians/1/edit
  def edit
  end

  # POST /anesthesians
  # POST /anesthesians.json
  def create
    @anesthesian = Anesthesian.new(anesthesian_params)

    respond_to do |format|
      if @anesthesian.save
        format.html { redirect_to anesthesians_path, notice: 'Anesthesian was successfully created.' }
        format.json { render :show, status: :created, location: @anesthesian }
      else
        format.html { render :new }
        format.json { render json: @anesthesian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anesthesians/1
  # PATCH/PUT /anesthesians/1.json
  def update
    respond_to do |format|
      if @anesthesian.update(anesthesian_params)
        format.html { redirect_to anesthesians_path, notice: 'Anesthesian was successfully updated.' }
        format.json { render :show, status: :ok, location: @anesthesian }
      else
        format.html { render :edit }
        format.json { render json: @anesthesian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anesthesians/1
  # DELETE /anesthesians/1.json
  def destroy
    @anesthesian.destroy
    respond_to do |format|
      format.html { redirect_to anesthesians_url, notice: 'Anesthesian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anesthesian
      @anesthesian = Anesthesian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anesthesian_params
      params.require(:anesthesian).permit(:name, :hospital_id)
    end
end
