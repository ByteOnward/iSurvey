class Statistics < ActiveRecord::Base
  has_many :records, :dependent => :destroy
  belongs_to :survey
  accepts_nested_attributes_for :records, :reject_if => lambda {|r| r[:survey_id].blank? }, :allow_destroy => true
end