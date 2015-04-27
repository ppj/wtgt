describe Place do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:country) }
  it { should validate_uniqueness_of(:name).scoped_to(:country) }
end
