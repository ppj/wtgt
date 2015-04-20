describe Destination do
  it { should belong_to(:user) }

  it { should belong_to(:place) }

  it { should validate_presence_of(:place_id) }

  describe "#name" do
    it "returns the name of the place" do
      destination = Fabricate(:destination)
      expect(destination.name).to eq(destination.place.name)
    end
  end
end
