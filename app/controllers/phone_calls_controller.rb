class PhoneCallsController < ApplicationController
  before_action :set_phone_call, only: [:show, :edit, :update, :destroy]

  # GET /phone_calls
  # GET /phone_calls.json
  def index
    @phone_calls = PhoneCall.all
  end

  def load_sub_form
    @response = params[:response]
    admission = Admission.find(params[:admission])
    if admission.phone_calls.where('patient_response = ?', Constants::NOT_READY_PERSONAL_REASONS).count >= 2 and @response == Constants::NOT_READY_PERSONAL_REASONS
      @not_ready = true
      @information = 'This Patient is Not Ready for surgery for three consecutive times due to personal reasons. Therefore he/she should be removed from waitlist'
    elsif admission.phone_calls.where('patient_response = ?', Constants::NOT_RESPONDED_TO_CALL).count >= 2 and @response == Constants::NOT_RESPONDED_TO_CALL
      @didnt_respond = true
      @information = 'This Patient has not responded to calls for three consecutive times. Therefore he/she should be removed from waitlist'
    end

    render partial: 'sub_form'
  end

  # GET /phone_calls/1
  # GET /phone_calls/1.json
  def show
  end

  # GET /phone_calls/new
  def new
    @phone_call = PhoneCall.new
    @phone_call.admission_id = params[:admission]
  end

  # GET /phone_calls/1/edit
  def edit
  end

  # POST /phone_calls
  # POST /phone_calls.json
  def create
    @phone_call = PhoneCall.new(phone_call_params)

    respond_to do |format|
      if @phone_call.save
        format.html { redirect_to @phone_call.admission.patient, notice: 'Phone call was successfully created.' }
        format.json { render :show, status: :created, location: @phone_call }
      else
        format.html { render :new }
        format.json { render json: @phone_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_calls/1
  # PATCH/PUT /phone_calls/1.json
  def update
    respond_to do |format|
      if @phone_call.update(phone_call_params)
        format.html { redirect_to @phone_call, notice: 'Phone call was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_call }
      else
        format.html { render :edit }
        format.json { render json: @phone_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_calls/1
  # DELETE /phone_calls/1.json
  def destroy
    @phone_call.destroy
    respond_to do |format|
      format.html { redirect_to phone_calls_url, notice: 'Phone call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_call
      @phone_call = PhoneCall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params
      params.require(:phone_call).permit(:admission_id, :patient_response, :information, :action, :new_appointment)
    end
end
