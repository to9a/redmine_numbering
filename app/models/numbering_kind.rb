class NumberingKind < ActiveRecord::Base
  unloadable
  has_many :numbering_items

  validates_presence_of :identifier
  validates_length_of :identifier, :maximum => 10
  validates_presence_of :disp_name
  validates_length_of :disp_name, :maximum => 20
end
