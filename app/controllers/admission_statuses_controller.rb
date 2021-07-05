class AdmissionStatusesController < ApplicationController
  before_action :set_admission_status, only: [:show, :edit, :update, :destroy]

  # GET /admission_statuses
  # GET /admission_statuses.json
  def index
    @admission_statuses = AdmissionStatus.all
  end

  # GET /admission_statuses/1
  # GET /admission_statuses/1.json
  def show
  end

  # GET /admission_statuses/new
  def new
    @admission_status = AdmissionStatus.new
    @admission_status.admission_id = params[:admission]
    @admission_status.status = params[:status]
  end

  # GET /admission_statuses/1/edit
  def edit
  end

  # POST /admission_statuses
  # POST /admission_statuses.json
  def create
    @admission_status = AdmissionStatus.new(admission_status_params)

    respond_to do |format|
      if @admission_status.save
        @admission_status.admission.update_attribute('status', @admission_status.status)
        format.html { redirect_to @admission_status.admission.patient, notice: 'Patient was successfully discharged.' }
        format.json { render :show, status: :created, location: @admission_status }
        logger.info("-----------------------#{@admission_status.admission.errors.inspect}")
      else
        format.html { render :new }
        format.json { render json: @admission_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admission_statuses/1
  # PATCH/PUT /admission_statuses/1.json
  def update
    respond_to do |format|
      if @admission_status.update(admission_status_params)
        @admission_status.admission.update(status: @admission_status.status)
        format.html { redirect_to @admission_status.admission.patient, notice: 'Patient was successfully discharged.' }
        format.json { render :show, status: :ok, location: @admission_status }
      else
        format.html { render :edit }
        format.json { render json: @admission_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admission_statuses/1
  # DELETE /admission_statuses/1.json
  def destroy
    @admission_status.destroy
    respond_to do |format|
      format.html { redirect_to admission_statuses_url, notice: 'Admission status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission_status
      @admission_status = AdmissionStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_status_params
      params.require(:admission_status).permit(:admission_id, :status_date, :status, :reason)
    end
end
