class PatientsController < ApplicationController
  authorize_resource
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :set_woredas, only: [:new, :create, :edit, :update, :create_from_search]

  # GET /patients
  # GET /patients.json
  def index
    @patients = (Patient.registered_today.blank? ? Patient.patients_no_admission : Patient.registered_today + Patient.patients_no_admission).uniq
  end

  def load_patients
      mrn = params[:mrn]
      first_name = params[:first_name]
      father_name = params[:father_name]
      grand_father_name = params[:grand_father_name]
      phone_number = params[:phone_number]
      age = params[:age]
      sex = params[:gender]
      @patients = Patient.search(mrn, first_name, father_name, grand_father_name, phone_number, sex)
      render partial: 'patients'
    end

  def appointment_list
    @appointments = Admission.appointed_for_next(3)
  end

  def admitted_list
    @admissions = Admission.where('status = ?', Constants::ADMITTED)
  end

  def load_age
    @age = Patient.age(params[:dob])
    render partial: 'age'
  end

  def load_appointments
    @appointments = Admission.appointed_for_next(params[:days])
    render partial: 'appointment_list'
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @surgical_services = SurgicalService.joins(:or_schedule=>:admission).where('admissions.patient_id = ?', @patient.id)
  end

  def create_from_search
      @patient = Patient.new(first_name: params[:patient_search][:first_name],
                             father_name: params[:patient_search][:father_name],
                             grand_father_name: params[:patient_search][:grand_father_name],
                             primary_telephone_number: params[:patient_search][:phone_number]
      )
      @patient.hospital_id = current_user.hospital_id
      render 'new'
    end

  # GET /patients/new
  def new
    @patient = Patient.new
    @patient.hospital_id = current_user.hospital_id
  end

  # GET /patients/1/edit
  def edit
    @age = Patient.age(@patient.date_of_birth)
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

  def set_woredas
    @woredas = Region.where(category: 'Woreda')
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:mrn, :hospital_id, :first_name, :father_name, :grand_father_name, :date_of_birth, :age, :sex, :date_of_registration,
                                      :region_id, :zone, :woreda, :kebele, :house_number, :primary_telephone_number, :name_of_contact_person, :contact_person_telephone_number)
    end
end
