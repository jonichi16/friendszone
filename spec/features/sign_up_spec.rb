require "rails_helper"

RSpec.describe "Sign In" do
  context "when user sign up for an account" do
    it "signs up successfully" do
      visit root_path
      find(:test_id, "signup-link").click

      find(:test_id, "email-field").fill_in with: "example@example.com"
      find(:test_id, "name-field").fill_in with: "Example"
      find(:test_id, "username-field").fill_in with: "example"
      find(:test_id, "gender-radio-female").click
      find(:test_id, "location-field").fill_in with: "Manila"
      find(:test_id, "password-field").fill_in with: "password"
      find(:test_id, "password-confirmation-field").fill_in with: "password"

      find(:test_id, "submit-btn").click

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("@example")
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end

  context "when required field is blank" do
    it "display error messages" do
      visit root_path
      find(:test_id, "signup-link").click

      find(:test_id, "submit-btn").click

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "when password don't match" do
    it "display error messages" do
      visit root_path
      find(:test_id, "signup-link").click

      find(:test_id, "email-field").fill_in with: "example@example.com"
      find(:test_id, "name-field").fill_in with: "Example"
      find(:test_id, "username-field").fill_in with: "example"
      find(:test_id, "gender-radio-female").click
      find(:test_id, "location-field").fill_in with: "Manila"
      find(:test_id, "password-field").fill_in with: "password"
      find(:test_id, "password-confirmation-field").fill_in with: "drowssap"

      find(:test_id, "submit-btn").click

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
