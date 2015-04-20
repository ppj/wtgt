describe PagesController do
  describe "GET front" do
    it_behaves_like "the boss" do
      let(:action) { get :front }
    end
  end
end
