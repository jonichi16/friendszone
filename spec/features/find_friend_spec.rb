require "rails_helper"

RSpec.describe "Find Friends" do
  let!(:current_user) { create(:user, name: "Current User") }
  let!(:friend_user) { create(:user, name: "Friend User") }
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
end
