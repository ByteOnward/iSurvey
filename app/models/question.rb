class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices, :dependent => :destroy
  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:content].blank? }, :allow_destroy => true

#TODO why we need add this.  
#  attr_accessible :type, :title, :choices_attributes
end
