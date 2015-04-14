class Place < ActiveRecord::Base
  validates_presence_of :name, :country
  belongs_to :destination
end
