describe DestinationsController do
  describe "GET index" do
    it_behaves_like "a security guard" do
      let(:action) { get :index }
    end

    it "sets @destinations ordered by updated_at descending" do
      bob = Fabricate :user
      destination1 = bob.destinations.create(Fabricate.attributes_for(:destination, updated_at: 1.day.ago))
      destination2 = bob.destinations.create(Fabricate.attributes_for(:destination))
      set_current_user bob
      get :index
      expect(assigns(:destinations)).to eq([destination2, destination1])
    end
  end
end
