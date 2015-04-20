describe SessionsController do
  describe "GET new" do
    it_behaves_like "the boss" do
      let(:action) { get :new }
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

  describe "DELETE destroy" do
    let(:bob) { Fabricate :user }
    before do
      set_current_user bob
      delete :destroy
    end

    it "redirects to the front page" do
      expect(response).to redirect_to root_path
    end

    it "signs the user out of the session" do
      expect(session[:user_id]).to be_nil
    end

    it "displays a logged-out message" do
      expect(flash[:success]).to be_present
    end
  end
end
