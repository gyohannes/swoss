class Patient < ApplicationRecord
  belongs_to :administration_unit
  has_many :admissions
  belongs_to :hospital

  validates :mrn, :first_name, :father_name, :grand_father_name, :date_of_birth, :age, :sex,
            :primary_telephone_number, :name_of_contact_person, :contact_person_telephone_number, presence: true

  validates :mrn, uniqueness: { message: "already registered, please go to the patient details and proceed with appointment/admission" }

  before_save :set_gregorian_dates
  after_find :set_current_age

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

  def latest_admission
    admissions.order('created_at DESC').first
  end

  def set_gregorian_dates
    self[:date_of_birth_gr] = Services::EthioGregorianDates.set_gregorian(self.date_of_birth, '/')
  end

  def set_current_age
    self.age = fromGregorianToEthiopic(Date.today.year, Date.today.month, Date.today.day).split('-')[0].to_i - date_of_birth.split('/')[2].to_i
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

  def woreda
    [administration_unit.parent.parent, administration_unit.parent, administration_unit].join(' - ')
  end

  def to_s
    full_name
  end

end