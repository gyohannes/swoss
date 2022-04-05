class Diagnosis < ApplicationRecord

  validates :name, presence: true

  def self.import(file)
    diagnoses = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      name = row[0]
      attrbts = {name: name}
      p = Diagnosis.find_or_create_by(attrbts)
      unless p.blank?
        diagnoses << p unless p.blank?
      end
    end
    return diagnoses
  end

  def to_s
    name
  end

end
