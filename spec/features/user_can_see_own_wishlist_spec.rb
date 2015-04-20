feature "List Of Wishlisted Destinations" do
  given(:bob) { Fabricate :user }

  background do
    Fabricate(:destination, user: bob)
    Fabricate(:destination, user: bob)
  end

  scenario "user can see the list of destinations he/she has added to the wishlist" do
    sign_in_user bob
    bob.destinations.each do |destination|
      expect_to_find destination.name
    end
  end
end
