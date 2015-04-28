feature "Add destination to wishlist" do
  given(:bob) { Fabricate :user }

  scenario "user adds destination to his/her wishlist" do
    sign_in_user bob
    click_on "Add Destination"
    fill_in "Category", with: "Leisure"
    check "Visited"
    fill_in "Name", with: "Melbourne"
    fill_in "Country", with: "Australia"
  end
end
