require "rails_helper"

RSpec.describe "Posting" do
  let!(:user) { create(:user, name: "John Doe") }
  let!(:friend_user) { create(:user, name: "Jane Doe") }
  let!(:other_user) { create(:user, name: "Joe Doe") }

  before do
    sign_in user
  end

  context "when user create a new post" do
    it "display the post" do
      visit root_path

      find(:test_id, "post-field").fill_in with: "Hello, World!"
      find(:test_id, "post-btn").click

      expect(page).to have_content("John Doe")
      expect(page).to have_content("Hello, World!")
    end

    it "does not display non-friend's post" do
      create(:friend, user:, friend: friend_user)
      create(:post, user: friend_user, content: "My post!")
      create(:post, user: other_user, content: "Awesome post!")

      visit root_path

      expect(page).to have_content("My post!")
      expect(page).not_to have_content("Awesome post!")
    end
  end
end
