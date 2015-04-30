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

  describe "GET edit" do
    let(:bob) { Fabricate :user }
    let(:destination) { Fabricate :destination, user: bob }
    before { set_current_user bob }

    it_behaves_like "a security guard" do
      let(:action) { get :edit, id: destination.id }
    end

    it "assigns @destination to the destination to be updated" do
      get :edit, id: destination.id
      expect(assigns(:destination)).to eq(destination)
    end
  end

  describe "POST update" do
    let(:bob) { Fabricate :user }
    let(:destination) { Fabricate :destination, user: bob }
    before { set_current_user bob }

    it_behaves_like "a security guard" do
      let(:action) { post :update, destination: {}, id: destination.id }
    end

    context "with a signed in user" do
      context "with valid inputs" do
        it "redirects to destinations page" do
          post :update, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}, id: destination.id
          expect(response).to redirect_to destinations_path
        end

        it "reuses a place if it already exists" do
          place = Place.create(name: "Pune", country: "India")
          post :update, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}, id: destination.id
          expect(Place.count).to eq(2)
          expect(Destination.first.place).to eq(place)
        end

        it "creates a new place if not found" do
          post :update, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}, id: destination.id
          expect(Place.last.name).to eq("Pune")
          expect(Place.last.country).to eq("India")
          expect(Destination.first.place).to eq(Place.last)
        end

        it "displays a message indicating successful update of destination" do
          post :update, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}, id: destination.id
          expect(flash[:success]).to be_present

        end

        it "updates the destination successfully" do
          post :update, destination: {category: "test", place: {name: "Pune", country: "India"}, visited: false}, id: destination.id
          expect(Destination.first.category).to eq("test")
        end
      end

      context "with invalid inputs" do
        it "does not update a destination when a new place cannot be created" do
          post :update, destination: {category: "test", place: {name: nil, country: "India"}, visited: false}, id: destination.id
          expect(bob.destinations.count).to eq(1)
        end

        it "does not update a destination when the place is already in the user's wishlist" do
          place = Fabricate(:place)
          bob.destinations.create(place: place)
          post :update, destination: {category: "test", place: {name: place.name, country: place.country}, visited: false}, id: destination.id
          expect(destination.reload.place).to_not eq(place)
        end

        it "does not update a destination that doesn't belong to the current user" do
          jane = Fabricate :user
          destination2 = Fabricate :destination, user: jane
          post :update, destination: {category: "test", place: {name: "new city", country: "Australia"}, visited: false}, id: destination2.id
          expect(destination2.reload.place.name).to_not eq("new city")
          expect(response).to redirect_to root_path
        end

        it "displays an error message" do
          post :update, destination: {category: "test", place: {name: nil, country: "India"}, visited: false}, id: destination.id
          expect(flash[:danger]).to be_present
        end

        it "re-renders the edit destinations form" do
          post :update, destination: {category: "test", place: {name: nil, country: "India"}, visited: false}, id: destination.id
          expect(response).to render_template :edit
        end
      end
    end
  end
end
