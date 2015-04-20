describe SessionsController do
  describe "GET new" do
    it "redirects to destinations path if already signed in" do
      set_current_user
      get :new
      expect(response).to redirect_to(destinations_path)
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }

    context "with valid credentials" do
      before { post :create, email: bob.email, password: bob.password }

      it "redirects to root path" do
        expect(response).to redirect_to(root_path)
      end

      it "signs the user into the session" do
        expect(session[:user_id]).to eq(bob.id)
      end

      it "shows flash message indicating successful login" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid credentials" do
      before { post :create, email: bob.email, password: bob.password[0..-2] }

      it "renders the sign-in form again" do
        expect(response).to render_template :new
      end

      it "shows an error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
