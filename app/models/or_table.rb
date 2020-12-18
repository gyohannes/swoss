class OrTable < ApplicationRecord
  belongs_to :or_block

  validates :name, :code, presence: true

  def to_s
    code
  end

  def block_and_name
    [or_block, code].join(" - ")
  end

end
