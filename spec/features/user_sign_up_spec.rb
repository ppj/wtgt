feature "User Signs Up" do
  scenario "with new credentials" do
    visit root_path
    click_on "Sign Up Now!"

    fill_in "Email Address", with: "heeho@hum.com"
    fill_in "Full Name", with: "Bobble Gum"
    fill_in "Password", with: "pwd"
    click_button "Sign Up"

    expect_to_find "Account created"
  end
end

