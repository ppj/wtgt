feature "List Of Wishlisted Destinations" do
  scenario "user can see the list of destinations he/she has added to the wishlist" do
    destination1 = Fabricate(:destination)
    destination2 = Fabricate(:destination)
    visit destinations_path
    expect_to_find destination1.name
    expect_to_find destination2.name
  end
end
