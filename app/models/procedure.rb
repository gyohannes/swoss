class Procedure < ApplicationRecord
  belongs_to :procedure_category
  has_many :admissions

  validates :name, presence: true

  def self.import(file)
    procedures = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      name = row[0]
      category = row[1].blank? ? nil : ProcedureCategory.find_or_create_by(code: row[1].strip)
      attrbts = {name: name, procedure_category_id: category.try(:id)}
      p = Procedure.find_or_create_by(attrbts)
      unless p.blank?
        procedures << p unless p.blank?
      end
    end
    return procedures
  end

  def to_s
    name
  end

end
