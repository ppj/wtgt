feature "List Of Wishlisted Destinations" do
  scenario "user can see the list of destinations he/she has added to the wishlist" do
    dest1 = Fabricate(:destination)
    dest2 = Fabricate(:destination)
    visit destinations_path
    expect_to_find dest1.name
    expect_to_find dest2.name
  end
end
