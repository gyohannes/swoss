class Patient < ApplicationRecord
  belongs_to :region
  has_many :admissions, dependent: :destroy
  belongs_to :hospital

  validates :mrn, :first_name, :father_name, :grand_father_name, :sex, :age_entry,
            :primary_telephone_number, :name_of_contact_person, :contact_person_telephone_number, presence: true
  validates :date_of_birth, presence: true, if: :age_in_dob
  validates :age, presence: true, if: :age_in_age

  validates :mrn, uniqueness: { message: "already registered, please go to the patient details and proceed with appointment/admission" }
  validates :primary_telephone_number, :contact_person_telephone_number, length: {is: 10}
  
  before_save :set_date_of_birth
  before_save :set_gregorian_dates

  scope :registered_today, -> {where('date(patients.created_at) = ?', Date.today)}
  scope :patients_no_admission, -> {includes(:admissions).where(admissions: {id: nil})}

  scope :list_by_hospital, -> (hospital) { hospital.patients unless hospital.blank? }
  scope :list_by_mrn, -> (mrn) { where('mrn = ?', mrn) unless mrn.blank? }
  scope :list_by_first_name, -> (first_name) { where("lower(first_name) LIKE ?", "#{first_name.downcase}%") unless first_name.blank? }
  scope :list_by_father_name, -> (father_name) { where("lower(father_name) LIKE ?", "#{father_name.downcase}%") unless father_name.blank? }
  scope :list_by_grand_father_name, -> (grand_father_name) { where("lower(grand_father_name) LIKE ?", "#{grand_father_name.downcase}%") unless grand_father_name.blank? }
  scope :list_by_phone, -> (phone) { where("primary_telephone_number LIKE ?", "#{phone}%") unless phone.blank?}
  scope :list_by_sex, -> (sex) { where("sex LIKE ?", "#{sex}%") unless sex.blank?}

  def self.search(mrn=nil, first_name=nil, father_name=nil, grand_father_name=nil, phone=nil, sex=nil)
    patients = []
    available_filters = {mrn => list_by_mrn(mrn), first_name => list_by_first_name(first_name), father_name => list_by_father_name(father_name),
                         grand_father_name => list_by_grand_father_name(grand_father_name),
                          phone => list_by_phone(phone), sex => list_by_sex(sex)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      patients = counter == 0 ? v : patients.merge(v)
      counter += 1
    end
    return patients.uniq
  end

  def age_in_age
    age_entry == 'age'
  end

  def age_in_dob
    age_entry == 'dob'
  end

  def latest_admission
    admissions.order('created_at DESC').first
  end

  def set_gregorian_dates
    self[:date_of_birth_gr] = Services::EthioGregorianDates.set_gregorian(self.date_of_birth, '/')
  end

  def set_date_of_birth
    if age_entry=='age'
      t = Date.today
      ethiopian_year = fromGregorianToEthiopic(t.year, t.month, t.day).split('-')[0].to_i
      year = ethiopian_year - age
      self[:date_of_birth] = "01/06/#{year}"
    end
  end

  def address
    [region, woreda, zone, house_number].join(' ')
  end

  def contact_name_and_address
    [name_of_contact_person, contact_person_telephone_number].join(' - ')
  end

  def name_and_mrn
    [full_name, mrn].join(' - ')
  end

  def full_name
    [first_name, father_name, grand_father_name].join(' ')
  end

  def to_s
    full_name
  end

end