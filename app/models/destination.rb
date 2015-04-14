class Destination < ActiveRecord::Base
  has_one :place
  validates_presence_of :place_id
end
