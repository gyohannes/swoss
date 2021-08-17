class Procedure < ApplicationRecord
  belongs_to :procedure_category
  has_many :admissions

  validates :name, presence: true

  def self.import(file)
    procedures = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      name = row[0]
      category = row[1].blank? ? nil : ProcedureCategory.find_or_create_by(code: row[1])
      attrbts = {name: name, procedure_category_id: category.try(:id)}
      procedure = Procedure.find_by(name: name)
      if procedure.blank?
        p = Procedure.new(attrbts)
        if p.save
          procedures << p unless p.blank?
        end
      end
    end
    return procedures
  end

  def to_s
    name
  end

end
