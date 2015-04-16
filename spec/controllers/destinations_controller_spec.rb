describe DestinationsController do
  describe "GET index" do
    it "sets @destinations ordered by updated_at descending" do
      destination1 = Fabricate(:destination, updated_at: 1.day.ago)
      destination2 = Fabricate(:destination)
      get :index
      expect(assigns(:destinations)).to eq([destination2, destination1])
    end
  end
end
