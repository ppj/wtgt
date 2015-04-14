describe Place do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:country) }
  it { should belong_to(:destination) }
end
