class Procedure < ApplicationRecord
  belongs_to :procedure_category
  has_many :admissions

  validates :name, presence: true

  def to_s
    name
  end

end
