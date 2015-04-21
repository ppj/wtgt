class User < ActiveRecord::Base
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email
  has_secure_password

  has_many :destinations, -> { order("updated_at DESC") }
end
