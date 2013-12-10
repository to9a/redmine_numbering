class NumberingItem < ActiveRecord::Base
  unloadable

  validates :project_name,
    :presence => true
  validates :numbering_category_id,
    :presence => true
  validates :numbering_kind_id,
    :presence => true
  validates :numbering_partner_id,
    :presence => true
  validates :document,
    :presence => true,
    :length => { :minimum => 1, :maximum => 100, :allow_blank => true }
  validates :remarks,
    :length => { :maximum => 100 }

  belongs_to :numbering_category, :class_name => 'NumberingCategory', :foreign_key => 'numbering_category_id'
  belongs_to :numbering_kind,     :class_name => 'NumberingKind',     :foreign_key => 'numbering_kind_id'
  belongs_to :numbering_partner,  :class_name => 'NumberingPartner',  :foreign_key => 'numbering_partner_id'
  
end
