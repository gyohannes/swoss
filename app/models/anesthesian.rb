class Anesthesian < ApplicationRecord
  belongs_to :hospital

  validates :name, presence:  true

  def to_s
    name
  end
end
