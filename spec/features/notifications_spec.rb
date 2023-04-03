require "rails_helper"

RSpec.describe "Notifications" do
  let!(:current_user) { create(:user, name: "John Doe") }
  let!(:user_one) { create(:user, name: "Jane Doe") }
  let!(:user_two) { create(:user, name: "Joe Doe") }

  before do
    sign_in current_user
  end

  context "when current user was added as a friend" do
    it "received a friend request notification" do
      create(:friend, user: user_one, friend: current_user)
      create(:friend, user: user_two, friend: current_user)

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_current_path(user_notifications_path(current_user))
      expect(page).to have_content("Jane Doe sent you a friend request")
      expect(page).to have_content("Joe Doe sent you a friend request")
    end
  end

  context "when current user friend request was accepted" do
    it "received a friend request notification" do
      create(:friend, user: current_user, friend: user_one)
      friend = user_one.friends.find_by(friend_id: current_user.id)
      friend.update(status: 1)

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_current_path(user_notifications_path(current_user))
      expect(page).to have_content("Jane Doe accepted your friend request")
    end
  end

  context "when current user click a friend request notification" do
    it "redirects to the page of the request" do
      friend = create(:friend, user: user_one, friend: current_user)
      notif = Notification.find_by(user_id: current_user.id, sender_id: user_one.id)

      visit root_path

      expect(notif.status).to eq("unseen")

      find(:test_id, "notifications-link").click

      notif.reload

      expect(notif.status).to eq("seen")

      find(:test_id, "notif-source-link").click

      notif.reload

      expect(page).to have_current_path(user_path(user_one))
      expect(notif.status).to eq("reviewed")
    end
  end
end
