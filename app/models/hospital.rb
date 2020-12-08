class Hospital < ApplicationRecord
  belongs_to :region
  has_many :patients

  has_one_attached :logo

  def to_s
    name
  end
end
