describe Destination do
  it { should validate_presence_of(:place_id) }

  it { should belong_to(:place) }

  describe "#name" do
    it "returns the name of the place" do
      destination = Fabricate(:destination)
      expect(destination.name).to eq(destination.place.name)
    end
  end
end
