class Procedure < ApplicationRecord
  belongs_to :procedure_category
  has_many :admissions

  def to_s
    name
  end

end
