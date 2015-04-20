shared_examples "a security guard" do
  it "redirects to the root page" do
    clear_current_session
    action
    expect(response).to redirect_to root_path
  end
end

shared_examples "the boss" do
  it "redirects to the destinations page" do
    set_current_user
    action
    expect(response).to redirect_to destinations_path
  end
end
