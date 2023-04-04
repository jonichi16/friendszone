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

  context "when current user visit his/her user page" do
    it "display current user's posts only" do
      create(:post, user:, content: "Test 1")
      create(:post, user:, content: "Test 2")
      create(:post, user: other_user, content: "Test 3")

      visit user_path(user)

      expect(page).to have_content("Test 1")
      expect(page).to have_content("Test 2")
      expect(page).not_to have_content("Test 3")
    end
  end

  context "when current user visit friend's user page" do
    it "display friend's posts only" do
      create(:post, user: friend_user, content: "Test 1")
      create(:post, user: friend_user, content: "Test 2")
      create(:post, user:, content: "Test 3")

      visit user_path(friend_user)

      expect(page).to have_content("Test 1")
      expect(page).to have_content("Test 2")
      expect(page).not_to have_content("Test 3")
    end
  end

  context "when current user visit non-friend's user page" do
    it "display non-friend's posts only" do
      create(:post, user: other_user, content: "Test 1")
      create(:post, user: other_user, content: "Test 2")
      create(:post, user:, content: "Test 3")

      visit user_path(other_user)

      expect(page).to have_content("Test 1")
      expect(page).to have_content("Test 2")
      expect(page).not_to have_content("Test 3")
    end
  end
end
