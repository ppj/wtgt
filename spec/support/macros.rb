def expect_to_find(text)
  expect(page).to have_content(text)
end

def sign_in_user(user = nil)
  user ||= Fabricate(:user)
  visit root_path
  click_on "Sign In"
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def set_current_user(user = nil)
  user ||= Fabricate(:user)
  session[:user_id] = user.id
end

def clear_current_session
  session[:user_id] = nil
end
