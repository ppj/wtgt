feature "Edit a destination" do
  given(:bob) { Fabricate :user }

  background do
    sign_in_user bob
    add_destination category: "Home", name: "Pune", country: "India"
  end

  scenario "user can edit a destination already in his/her wishlist" do
    visit destinations_path
    click_on "Pune (Country: India)"
    fill_in "Name", with: "Mumbai"
    check "Visited"
    click_on "Update"
    expect_to_find "Mumbai (Country: India)"
  end
end

def add_destination(destination)
  visit destinations_path
  click_on "Add Destination"
  fill_in "Category", with: destination[:category]
  uncheck "Visited"
  fill_in "Name", with: destination[:name]
  fill_in "Country", with: destination[:country]
  click_on "Add"
end
