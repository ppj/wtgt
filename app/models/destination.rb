class Destination < ActiveRecord::Base
  belongs_to :place
  validates_presence_of :place_id

  delegate :name, to: :place
end
