describe UsersController do
  describe "GET new" do
    it_behaves_like "the boss" do
      let(:action) { get :new }
    end

    it "assigns @user to a new User record" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to root_path
      end

      it "sets flash message indicating creation of account" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        post :create, user: Fabricate.attributes_for(:user, email: "")
      end

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "sets @user to a new User" do
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the sign-up form" do
        expect(response).to render_template :new
      end

      it "shows flash error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET show" do
    it_behaves_like "a security guard" do
      let(:action) { get :show }
    end

    it "assigns @user to current user" do
      set_current_user
      get :show
      expect(assigns(:user)).to eq(current_user)
    end
  end

  describe "GET edit" do
    it_behaves_like "a security guard" do
      let(:action) { get :edit }
    end

    it "assigns @user to current user" do
      set_current_user
      get :edit
      expect(assigns(:user)).to eq(current_user)
    end
  end

  describe "POST update" do
    let(:bob) { Fabricate :user }

    it_behaves_like "a security guard" do
      let(:action) { post :update, id: bob.id, user: bob.attributes }
    end

    context "with valid inputs" do
      before { set_current_user bob }

      it "redirects to profile page" do
        post :update, id: bob.id, user: bob.attributes
        expect(response).to redirect_to profile_path
      end

      it "updates users attributes" do
        email = Faker::Internet.email
        city  = Faker::Address.city
        country = Faker::Address.country
        post :update, id: bob.id, user: {email: email, hometown: city, country: country}
        expect(bob.reload.email).to eq(email)
        expect(bob.hometown).to eq(city)
        expect(bob.country).to eq(country)
      end

      it "displays a flash success message" do
        post :update, id: bob.id, user: bob.attributes
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before { set_current_user bob }

      it "re-renders the edit form" do
        post :update, id: bob.id, user: {email: nil}
        expect(response).to render_template :edit
      end

      it "displays a flash error message" do
        post :update, id: bob.id, user: {email: Fabricate(:user).email}
        expect(flash[:danger]).to be_present
      end
    end
  end
end
