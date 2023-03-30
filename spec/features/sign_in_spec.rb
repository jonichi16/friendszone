require "rails_helper"

RSpec.describe "Sign In" do
  let(:user) { create(:user) }

  context "when user signed in with valid account" do
    it "allow the user to sign in with email" do
      visit root_path

      find(:test_id, "login-field").fill_in with: user.email
      find(:test_id, "password-field").fill_in with: user.password

      find(:test_id, "submit-btn").click

      expect(page).to have_current_path(root_path)
    end

    it "allow the user to sign in with username" do
      visit root_path

      find(:test_id, "login-field").fill_in with: user.username
      find(:test_id, "password-field").fill_in with: user.password

      find(:test_id, "submit-btn").click

      expect(page).to have_current_path(root_path)
    end
  end

  context "when user signed in with invalid account" do
    it "display an error message" do
      visit root_path

      find(:test_id, "login-field").fill_in with: "invalidemail"
      find(:test_id, "password-field").fill_in with: user.password

      find(:test_id, "submit-btn").click

      expect(page).to have_content("Invalid Login or password.")
    end
  end
end
