class Destination < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  validates_presence_of :place_id
  validates_presence_of :user_id
  validates_uniqueness_of :place_id, scope: :user_id

  delegate :name, to: :place
  delegate :country, to: :place
end
