describe PagesController, type: :controller do
  describe "GET front" do
    it "redirects to destinations path for signed in user" do
      set_current_user
      get :front
      expect(response).to redirect_to destinations_path
    end
  end
end
