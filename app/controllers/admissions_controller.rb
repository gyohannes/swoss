class AdmissionsController < ApplicationController
  authorize_resource
  before_action :set_admission, only: [:show, :edit, :update, :destroy, :admission, :discharge]
  before_action :load, only: [:load_sub_form, :admission, :new, :create, :edit, :update]

  def load
    @beds = Bed.where(status: nil)
  end

  # GET /admissions
  # GET /admissions.json
  def index
    @admissions = Admission.where('appointment_date_gr < ? and status = ?', Date.today, Constants::ON_WAITING_LIST)
  end

  def load_sub_form
    @admission_type = params[:admission_type]
    render partial: 'sub_form'
  end

  def load_category
    procedure = Procedure.find(params[:procedure])
    @category = procedure.procedure_category
    render partial: 'category'
  end

  def load_priority
    procedure = Procedure.find(params[:procedure])
    @category = procedure.procedure_category
    render partial: 'priority'
  end

  def load_submit
    cat_1 = ProcedureCategory.find_by(code: 1)
    procedure = Procedure.find(params[:procedure])
    priority = params[:priority]
    listing_status = params[:listing_status]
    appointment_date = params[:appointment_date]
    appointment_date_gr = Services::EthioGregorianDates.set_gregorian(appointment_date, '/')
    appointment_length_days = priority == "true" ? cat_1.max_appointment_days : procedure.procedure_category.max_appointment_days
    if appointment_date_gr > Date.today + appointment_length_days.days
      @message = 'You have selected a date range that is longer than what is allowed for the selected procedure category and listing status. Would you like to continue?'
    end
    render partial: 'submit'
  end

  def load_information
    procedure = Procedure.find_by(id: params[:procedure])
    priority = params[:priority]
    category = priority == 'true' ? ProcedureCategory.find_by(code: 1) : procedure.procedure_category
    @information = params[:listing_status].blank? ? '' : ( params[:listing_status] == Constants::READY ? "For this patient the Maximum appointment period should not exceed #{category.max_appointment_days} days" :
                       "For this patient the Maximum appointment period should not exceed #{category.max_appointment_days} days and the Maximum postponment days should not exceed #{category.max_postponment_days} days ")

    render partial: 'information'
  end

  def patients_by_status_by_month
    patients = []
    date_range = (Date.today.months_ago(11)..Date.today).uniq{|d| d.month}.collect{|y| y.change(day: 15)}
    Constants::PATIENT_STATUS.each do |s|
      patients << {name: s, data: date_range.map{|d| [d.strftime("%B"), Admission.waiting_month_total(s,d)]} }
    end
    render json: patients
  end

  def patients_by_status_by_month
    from = Date.today - 11.months
    to = Date.today
    eth_from = fromGregorianToEthiopic(from.year, from.month, from.day).split('-')
    eth_to = fromGregorianToEthiopic(to.year, to.month, to.day).split('-')
    eth_from = eth_from[1] + '/' + eth_from[0]
    eth_to = eth_to[1] + '/' + eth_to[0]
    from_gr = Services::EthioGregorianDates.eth_month_reporting_start(eth_from) + 5.days
    to_gr = Services::EthioGregorianDates.eth_month_reporting_end(eth_to) - 5.days
    date_range = (from_gr..to_gr).uniq{|d| [d.month, d.year]}.collect{|y| y.change(day: 15)}
    patients = []
    Constants::PATIENT_STATUS.each do |s|
      patients << {name: s,
                       data: date_range.map{|d| [AmharicMonths[fromGregorianToEthiopic(d.year, d.month, d.day).split('-')[1]],
                                                 Admission.waiting_month_total(s,d) ]} }
    end
    render json: patients
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  def admission
  end

  # GET /admissions/new
  def new
    @admission = Admission.new
    @admission.patient_id = params[:patient]
  end


  # GET /admissions/1/edit
  def edit
    @admission_type = @admission.admission_type
  end

  # POST /admissions
  # POST /admissions.json
  def create
    @admission = Admission.new(admission_params)
    @admission_type = @admission.admission_type
    @admission.user_id = current_user.id
    respond_to do |format|
      if @admission.save
        status = @admission.admission_date_gr.blank? ? Constants::ON_WAITING_LIST : Constants::ADMITTED
        as = @admission.admission_statuses.build(status: status, status_date: Date.today)
        if as.save
          @admission.update_attribute('status', status)
        end
        format.html { redirect_to @admission.patient, notice: 'Admission was successfully created.' }
        format.json { render :show, status: :created, location: @admission }
      else
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admissions/1
  # PATCH/PUT /admissions/1.json
  def update
    @admission_type = admission_params[:admission_type]
    respond_to do |format|
      if @admission.update(admission_params)
        status = @admission.admission_date_gr.blank? ? Constants::ON_WAITING_LIST : Constants::ADMITTED
        if @admission.status != status
          as = @admission.admission_statuses.build(status: status, status_date: Date.today)
          if as.save
            @admission.update_attribute('status', status)
          end
        end
        format.html { redirect_to @admission.patient, notice: 'Admission was successfully updated.' }
        format.json { render :show, status: :ok, location: @admission }
      else
        format.html { render :edit }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admissions/1
  # DELETE /admissions/1.json
  def destroy
    @admission.destroy
    respond_to do |format|
      format.html { redirect_to admissions_url, notice: 'Admission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission
      @admission = Admission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_params
      params.require(:admission).permit(:user_id, :patient_id, :date_of_registration, :admission_type, :diagnosis_id, :procedure_id,
                                        :procedure_category_id, :priority, :reason_for_admission, :physician_id, :department_id, :referring_facility,
                                        :bed_id, :listing_status, :information, :appointment_date, :admission_date, :admission_time, :ward_id, :payment_type_id)
    end
end
