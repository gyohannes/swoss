class ScrubNursesController < ApplicationController
  before_action :set_scrub_nurse, only: [:show, :edit, :update, :destroy]

  # GET /scrub_nurses
  # GET /scrub_nurses.json
  def index
    @scrub_nurses = ScrubNurse.all
  end

  # GET /scrub_nurses/1
  # GET /scrub_nurses/1.json
  def show
  end

  # GET /scrub_nurses/new
  def new
    @scrub_nurse = ScrubNurse.new
  end

  # GET /scrub_nurses/1/edit
  def edit
  end

  # POST /scrub_nurses
  # POST /scrub_nurses.json
  def create
    @scrub_nurse = ScrubNurse.new(scrub_nurse_params)

    respond_to do |format|
      if @scrub_nurse.save
        format.html { redirect_to scrub_nurses_path, notice: 'Scrub nurse was successfully created.' }
        format.json { render :show, status: :created, location: @scrub_nurse }
      else
        format.html { render :new }
        format.json { render json: @scrub_nurse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrub_nurses/1
  # PATCH/PUT /scrub_nurses/1.json
  def update
    respond_to do |format|
      if @scrub_nurse.update(scrub_nurse_params)
        format.html { redirect_to scrub_nurses_path, notice: 'Scrub nurse was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrub_nurse }
      else
        format.html { render :edit }
        format.json { render json: @scrub_nurse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrub_nurses/1
  # DELETE /scrub_nurses/1.json
  def destroy
    @scrub_nurse.destroy
    respond_to do |format|
      format.html { redirect_to scrub_nurses_url, notice: 'Scrub nurse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrub_nurse
      @scrub_nurse = ScrubNurse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrub_nurse_params
      params.require(:scrub_nurse).permit(:name, :hospital_id)
    end
end
