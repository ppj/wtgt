describe Destination do
  it { should have_one(:place) }
  it { should validate_presence_of(:place_id) }
end
