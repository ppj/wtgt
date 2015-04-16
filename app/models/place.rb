class Place < ActiveRecord::Base
  validates_presence_of :name, :country
end
