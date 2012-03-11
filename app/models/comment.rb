class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey

  attr_accessible :content

  validates :user_id, :presence => true
  validates :survey_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 2000 }

  default_scope :order => 'comments.created_at Desc'
end
