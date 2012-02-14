class Choice < ActiveRecord::Base
  belongs_to :question
#  belongs_to :survey, :through => :question
end
