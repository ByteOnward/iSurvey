class Survey < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_one :statistics
  has_many :comments, :dependent => :destroy
  
#  has_many :choices, :through => :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda {|q| q[:title].blank? }, :allow_destroy => true

  validates :name, :presence => true, :uniqueness => true
  validates :desc, :presence => true

end
