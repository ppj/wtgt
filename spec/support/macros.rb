def expect_to_find(text)
  expect(page).to have_content(text)
end

def sign_in_user(user = nil)
  user ||= Fabricate(:user)
  visit root_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button "Sign In"
end

def set_current_user(user = nil)
  user ||= Fabricate(:user)
  session[:user_id] = user.id
end

def clear_current_session
  session[:user_id] = nil
end
