feature "User Edits Profile" do
  scenario "with existing credentials" do
    bob = Fabricate(:user)
    sign_in_user bob

    click_on bob.fullname
    click_on "Account"
    expect_to_find bob.fullname
    expect_to_find bob.email

    new_city = Faker::Address.city
    new_country = Faker::Address.country
    click_on "Edit"
    fill_in "Hometown", with: new_city
    fill_in "Country", with: new_country
    click_on "Update"
    expect_to_find "Profile"
    expect_to_find new_city
    expect_to_find new_country
  end
end

