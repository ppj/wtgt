require 'spec_helper'

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

      it "re-renders the sign-up form" do
        expect(response).to render_template :new
      end

      it "shows flash error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
