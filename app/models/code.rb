class Code < ActiveRecord::Base
  attr_accessible :code, :name, :parent_id, :describe, :footprint, :manufacturer, :partNum
  
end
