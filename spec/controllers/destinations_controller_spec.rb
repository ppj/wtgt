describe DestinationsController do
  describe "GET index" do
    let(:bob) { Fabricate :user }
    let(:destination1) { bob.destinations.create(Fabricate.attributes_for(:destination, updated_at: 1.day.ago)) }
    let(:destination2) { bob.destinations.create(Fabricate.attributes_for(:destination)) }
    before { set_current_user bob }

    it_behaves_like "a security guard" do
      let(:action) { get :index }
    end

    it "sets @destinations to user's destinations ordered by updated_at descending" do
      get :index
      expect(assigns(:destinations)).to eq([destination2, destination1])
    end

    it "doesn't add other users' destinations in @destinations" do
      jane = Fabricate :user
      destination3 = jane.destinations.create(Fabricate.attributes_for(:destination))
      get :index
      expect(assigns(:destinations)).to_not include(destination3)
    end
  end
end
