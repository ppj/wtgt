describe User do
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of (:email) }
  it { should have_secure_password }

  it { should have_many(:destinations) }
end
