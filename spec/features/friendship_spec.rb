require "rails_helper"

RSpec.describe "Friendship" do
  let!(:current_user) { create(:user, name: "Current User") }
  let!(:friend_user) { create(:user, name: "Friend User", location: "manila") }
  let!(:other_user) { create(:user, name: "Other User") }

  before do
    create(:friend, user: current_user, friend: friend_user)
    sign_in current_user
  end

  context "when user visit Find Friends page" do
    it "display other users name" do
      visit root_path

      expect(find(:test_id, "find-friends-link").text).to eq("Find Friends")

      find(:test_id, "find-friends-link").click

      expect(page).to have_content(other_user.name)
      expect(page).not_to have_content(current_user.name)
      expect(page).not_to have_content(friend_user.name)
    end
  end

  context "when user add a friend" do
    it "removes the friend in the list" do
      visit root_path

      find(:test_id, "find-friends-link").click
      find(:test_id, "add-friend-btn-user_#{other_user.id}").click

      expect(page).not_to have_content(other_user.name)
      expect(page).to have_current_path(users_path)
    end
  end

  context "when user visit the friends list" do
    it "display friend's name" do
      visit root_path

      find(:test_id, "profile-link").click

      expect(find(:test_id, "friends-btn").text).to eq("Friends")

      find(:test_id, "friends-btn").click

      expect(page).to have_content(friend_user.name)
      expect(page).to have_content("Manila")
      expect(page).not_to have_content(other_user.name)
      expect(page).not_to have_content(current_user.name)
    end
  end
end
