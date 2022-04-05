class OrSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :admission
  belongs_to :surgeon
  belongs_to :anesthesia_type
  belongs_to :scrub_nurse
  belongs_to :circulating_nurse
  belongs_to :schedule_order, optional: true
  belongs_to :or_block
  belongs_to :or_table
  has_one :surgical_service, dependent: :destroy
  has_many :or_schedule_anesthesians, dependent: :destroy
  has_many :anesthesians, through: :or_schedule_anesthesians

  before_save :set_gregorian_dates
  after_save :set_scheduled_time, if: :elective_procedure
  before_save :remove_blank_assisstant_surgeons

  validates :procedure_type, presence: true
  validates :scheduled_date, :scheduled_time, presence: true, if: :elective_procedure

  accepts_nested_attributes_for :or_schedule_anesthesians, allow_destroy: :true

  def elective_procedure
    procedure_type == Constants::ELECTIVE
  end

  def remove_blank_assisstant_surgeons
    assisstant_surgeons.reject!(&:blank?)
  end

  def set_gregorian_dates
    self[:scheduled_date_gr] = Services::EthioGregorianDates.set_gregorian(self.scheduled_date, '/')
  end

  def set_scheduled_time
    if scheduled_date_gr.year != scheduled_time.year or scheduled_date_gr.month != scheduled_time.month or scheduled_date_gr.day != scheduled_time.day
      update(scheduled_time: scheduled_time.change(year: scheduled_date_gr.year, month: scheduled_date_gr.month, day: scheduled_date_gr.day))
    end
  end

  def self.elective_procedures_scheduled(department, from, to)
    joins(:admission).where('department_id = ? and admission_type = ? and scheduled_date_gr >= ? and scheduled_date_gr <= ?',
                            department, Constants::ELECTIVE, from, to).count
  end

end
