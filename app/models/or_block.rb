class OrBlock < ApplicationRecord
  belongs_to :hospital
  has_many :or_tables

  validates :name, presence: true

  def to_s
    name
  end
end
