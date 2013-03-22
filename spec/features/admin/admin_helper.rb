def login_as_admin
  admin = Factory(:admin_user)
  visit new_admin_user_session_path
  fill_in "Email", with: admin.email
  fill_in "Password", with: admin.password
  click_on "Sign in"
end
