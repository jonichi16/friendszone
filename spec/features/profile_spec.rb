require "rails_helper"

RSpec.describe "Profile" do
  let!(:current_user) { create(:user, location: "manila") }
  let!(:other_user) { create(:user, location: "manila") }

  before do
    sign_in current_user
    visit root_path
  end

  context "when user edit the profile" do
    it "renders the edit profile page" do
      find(:test_id, "profile-link").click
      find(:test_id, "edit-profile-btn").click

      expect(page).to have_current_path(edit_user_registration_path)
    end
  end

  context "when current user visit non-friend page" do
    it "display a button to add friend" do
      find(:test_id, "find-friends-link").click
      find(:test_id, "user_#{other_user.id}").click

      expect(page).to have_current_path(user_path(other_user))
      expect(page).not_to have_content("Edit Profile")
      expect(page).to have_content("Add Friend")
    end
  end

  context "when current user visit requested user page" do
    before do
      current_user.friends.create(friend_id: other_user.id)
    end

    it "display a button to cancel request" do
      visit user_path(other_user)

      expect(page).to have_current_path(user_path(other_user))
      expect(page).to have_content("Cancel Request")
    end
  end

  context "when current user cancel the friend request" do
    before do
      current_user.friends.create(friend_id: other_user.id)
    end

    it "display a button to add a friend" do
      visit user_path(other_user)

      find(:test_id, "cancel-request-btn-user_#{other_user.id}").click

      expect(page).not_to have_content("Cancel Request")
      expect(page).to have_content("Add Friend")
    end
  end

  context "when current user visit requester user page" do
    before do
      other_user.friends.create(friend_id: current_user.id)
    end

    it "display a button to accept or delete request" do
      visit user_path(other_user)

      expect(page).to have_content("Accept Request")
      expect(page).to have_content("Delete Request")

      find(:test_id, "accept-request-btn-user_#{other_user.id}").click

      expect(page).to have_content("Unfriend")
      expect(page).to have_current_path(user_path(other_user))

      find(:test_id, "cancel-request-btn-user_#{other_user.id}").click

      expect(page).to have_content("Add Friend")
    end
  end

  context "when current user visit his/her own profile" do
    before do
      other_user.friends.create(friend_id: current_user.id)
    end

    it "display the details section of the user" do
      find(:test_id, "profile-link").click

      expect(page).to have_content("Joined on #{current_user.created_at.strftime('%B %Y')}")
      expect(page).to have_content("Followed by 1 person")
      expect(page).to have_content("Manila")
    end
  end

  context "when current user visit requested profile" do
    before do
      other_user.friends.create(friend_id: current_user.id)
    end

    it "display the details of other user" do
      visit user_path(other_user)

      expect(page).to have_content("Joined on #{current_user.created_at.strftime('%B %Y')}")
      expect(page).to have_content("Followed by 0 people")
      expect(page).to have_content("Manila")
    end
  end
end
