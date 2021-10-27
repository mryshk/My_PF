module LoginModule
  def login(listener)
    visit new_listener_session_path
    fill_in 'email', with: listener.email
    fill_in 'password', with: "password"
    fill_in 'password_confirmation',with: "password"
    click_button 'LogIn'
  end
end