class AdministrationUnit < ApplicationRecord
  belongs_to :parent_administration_unit, optional: true, :class_name => 'AdministrationUnit', :foreign_key => "parent_administration_unit_id"
  has_many :sub_administration_units, :class_name => 'AdministrationUnit', :foreign_key => "parent_administration_unit_id"

  def self.top_administration_unit
    where(parent_administration_unit_id: '').first
  end

  def self.administration_tree
    admin_unit = top_administration_unit
    [admin_unit.org_children] unless admin_unit.blank?
  end

  def org_children
    {
        text: name,
        type: category,
        id: id,
        nodes: sub_administration_units.blank? ? nil
                   : sub_administration_units.collect{|x| x.org_children }
    }
  end

  def parent
    AdministrationUnit.find_by(id: parent_administration_unit_id)
  end

  def current_status
    status == true ? 'Active' : 'Inactive'
  end

  def to_s
    name
  end

end
