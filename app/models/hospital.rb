class Hospital < ApplicationRecord
  belongs_to :region
  has_many :patients
  has_many :users
  has_one_attached :logo

  def to_s
    name
  end
end
