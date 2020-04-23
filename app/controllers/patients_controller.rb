class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
  end

  def appointment_list
    @appointments = []
  end

  def load_age
    @age = fromGregorianToEthiopic(Date.today.year, Date.today.month, Date.today.day).split('-')[0].to_i - params[:dob].split('/')[2].to_i
    render partial: 'age'
  end

  def load_appointments
    @appointments = Admission.appointed_for_next(params[:days].to_i)
    render partial: 'appointment_list'
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    @patient.hospital_id = current_user.hospital_id
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to new_admission_path(patient: @patient.id), notice: 'Patient was successfully Registered. Please Fill the Clinical and Appointment Form' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:mrn, :hospital_id, :first_name, :father_name, :grand_father_name, :date_of_birth, :age, :sex, :date_of_registration,
                                      :region_id, :zone, :woreda, :kebele, :house_number, :primary_telephone_number, :name_of_contact_person, :contact_person_telephone_number)
    end
end
