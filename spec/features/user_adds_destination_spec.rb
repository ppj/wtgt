feature "Add destination to wishlist" do
  given(:bob) { Fabricate :user }

  scenario "user adds destination to his/her wishlist" do
    sign_in_user bob
    click_on "Add Destination"
    fill_in "Category", with: "Leisure"
    check "Visited"
  end
end
