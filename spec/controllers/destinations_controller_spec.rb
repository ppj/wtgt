describe DestinationsController do
  describe "GET index" do
    it "sets @destinations" do
      dest1 = Fabricate(:destination)
      dest2 = Fabricate(:destination)
      get :index
      expect(assigns(:destinations)).to match_array([dest1, dest2])
    end
  end
end
