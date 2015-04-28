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

  describe "GET new" do
    it_behaves_like "a security guard" do
      let(:action) { get :new }
    end

    context "with a signed in user" do
      let(:bob) { Fabricate :user }
      before { set_current_user bob }

      it "sets @destination to a new Destination" do
        get :new
        expect(assigns(:destination)).to be_a_new(Destination)
      end
    end
  end

  describe "POST create" do
    it_behaves_like "a security guard" do
      let(:action) { post :create }
    end

    context "with a signed in user" do
      context "with valid inputs" do
        let(:bob) { Fabricate :user }
        before { set_current_user bob }

        it "creates a new place if it doesn't exist already" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(Place.count).to eq(1)
        end

        it "uses an existing place if found" do
          place = Place.create(name: "Pune", country: "India")
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(Place.count).to eq(1)
          expect(Destination.first.place).to eq(place)
        end

        it "creates a new destination for the user" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(bob.destinations.count).to eq(1)
        end

        it "displays a message about successful creation of the destination" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(flash[:success]).to be_present
        end

        it "redirects to the user's destinations page" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(response).to redirect_to destinations_path
        end
      end

      context "with invalid inputs" do
        let(:place) { Place.create(name: "Pune", country: "India") }
        let(:bob)   { Fabricate :user }

        before do
          set_current_user bob
          bob.destinations.create(place: place)
        end

        it "does not create a destination when a new place cannot be created" do
          post :create, destination: {category: "test", place: {name: nil, country: "India"}, visited: false}
          expect(bob.destinations.count).to eq(1)
        end

        it "does not create a destination when the place is already in the user's wishlist" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(bob.destinations.count).to eq(1)
        end

        it "displays an error message" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(flash[:danger]).to be_present
        end

        it "re-renders the new destinations form" do
          post :create, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}
          expect(response).to render_template :new
        end
      end
    end
  end
end
