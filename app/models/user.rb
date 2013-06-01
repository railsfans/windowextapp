class User < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :avatar
  has_attached_file :avatar

end
