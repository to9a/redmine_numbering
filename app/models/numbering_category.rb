class NumberingCategory < ActiveRecord::Base
  unloadable
  has_many :numbering_items

  # validates_presence_of :identifier
  # validates_length_of :identifier, :maximum => 10
  # validates_presence_of :disp_name
  # validates_length_of :disp_name, :maximum => 20
  
  validates :identifier,
    :presence => true,
    :length => { :minimum => 1, :maximum => 10, :allow_blank => true }
  validates :disp_name,
    :presence => true,
    :length => { :minimum => 1, :maximum => 20, :allow_blank => true }

end
