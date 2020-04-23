class Patient < ApplicationRecord
  belongs_to :region
  has_many :admissions
  belongs_to :hospital

  validates :mrn, :first_name, :father_name, :grand_father_name, :date_of_birth, :age, :sex,
            :region, :zone, :woreda, :kebele, :house_number, :primary_telephone_number, :name_of_contact_person, :contact_person_telephone_number, presence: true
  before_save :set_gregorian_dates
  after_find :set_current_age

  scope :list_by_hospital, -> (hospital) { hospital.patients unless hospital.blank? }
  scope :list_by_mrn, -> (mrn, hospital) { list_by_hospital(hospital).where('mrn = ?', mrn) unless mrn.blank? }
  scope :list_by_first_name, -> (first_name, hospital) { list_by_hospital(hospital).where('first_name = ?', first_name) unless first_name.blank? }
  scope :list_by_father_name, -> (father_name, hospital) { list_by_hospital(hospital).where('father_name = ?', father_name) unless father_name.blank? }

  def self.search(hospital=nil, mrn=nil, first_name=nil, father_name=nil)
    patients = []
    available_filters = {hospital => list_by_hospital(hospital), mrn => list_by_mrn(mrn, hospital), first_name => list_by_first_name(first_name, hospital),
                         father_name => list_by_father_name(father_name, hospital) }.select{|k,v| !k.blank?}
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

  def to_s
    full_name
  end

end