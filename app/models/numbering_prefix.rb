class NumberingPrefix < ActiveRecord::Base
  unloadable

  validates_presence_of :fixed
  validates_length_of :fixed, :maximum => 255
  validates_length_of :subject, :maximum => 255

  validates_length_of :document, :maximum => 255
end
