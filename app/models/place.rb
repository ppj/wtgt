class Place < ActiveRecord::Base
  validates_presence_of :name, :country
  validates_uniqueness_of :name, scope: :country
end
