feature "User Signs In" do
  scenario "with existing credentials" do
    bob = Fabricate(:user)
    sign_in_user bob
    expect_to_find "You have logged in successfully."
    expect_to_find bob.fullname
  end
end

