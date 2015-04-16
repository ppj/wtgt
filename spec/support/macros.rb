def expect_to_find(text)
  expect(page).to have_content(text)
end
