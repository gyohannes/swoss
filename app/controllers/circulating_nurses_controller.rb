class CirculatingNursesController < ApplicationController
  before_action :set_circulating_nurse, only: [:show, :edit, :update, :destroy]

  # GET /circulating_nurses
  # GET /circulating_nurses.json
  def index
    @circulating_nurses = CirculatingNurse.all
  end

  # GET /circulating_nurses/1
  # GET /circulating_nurses/1.json
  def show
  end

  # GET /circulating_nurses/new
  def new
    @circulating_nurse = CirculatingNurse.new
  end

  # GET /circulating_nurses/1/edit
  def edit
  end

  # POST /circulating_nurses
  # POST /circulating_nurses.json
  def create
    @circulating_nurse = CirculatingNurse.new(circulating_nurse_params)

    respond_to do |format|
      if @circulating_nurse.save
        format.html { redirect_to circulating_nurses_path, notice: 'Circulating nurse was successfully created.' }
        format.json { render :show, status: :created, location: @circulating_nurse }
      else
        format.html { render :new }
        format.json { render json: @circulating_nurse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /circulating_nurses/1
  # PATCH/PUT /circulating_nurses/1.json
  def update
    respond_to do |format|
      if @circulating_nurse.update(circulating_nurse_params)
        format.html { redirect_to circulating_nurses_path, notice: 'Circulating nurse was successfully updated.' }
        format.json { render :show, status: :ok, location: @circulating_nurse }
      else
        format.html { render :edit }
        format.json { render json: @circulating_nurse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circulating_nurses/1
  # DELETE /circulating_nurses/1.json
  def destroy
    @circulating_nurse.destroy
    respond_to do |format|
      format.html { redirect_to circulating_nurses_url, notice: 'Circulating nurse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circulating_nurse
      @circulating_nurse = CirculatingNurse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circulating_nurse_params
      params.require(:circulating_nurse).permit(:name, :hospital_id)
    end
end
