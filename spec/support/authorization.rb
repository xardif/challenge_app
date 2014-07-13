module SpecHelpers
  module Authorization
    def sign_in_as(user)
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Sign in"
      @user = user
    end
    def sign_out
      click_on "Sign out"
    end
  end
end
