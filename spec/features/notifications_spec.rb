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

      find(:test_id, "notification_#{notif.id}").click

      notif.reload

      expect(page).to have_current_path(user_path(user_one))
      expect(notif.status).to eq("reviewed")
    end
  end

  context "when a user comment on current user's post" do
    it "received a comment notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:comment, user: user_one, post:, content: "A comment")

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_content("Jane Doe commented on your post")
    end
  end

  context "when current user comment on his/her post" do
    it "will not send a notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:comment, user: current_user, post:, content: "A comment")
      create(:comment, user: user_one, post:, content: "My comment")

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_content("Jane Doe commented on your post")
      expect(page).not_to have_content("John Doe commented on your post")
    end
  end

  context "when user clicked a comment notif" do
    it "will redirect to the post page" do
      post = create(:post, user: current_user, content: "A post")
      create(:comment, user: user_one, post:, content: "A comment")
      notif = Notification.find_by(user_id: current_user.id)

      visit notifications_path

      find(:test_id, "notification_#{notif.id}").click

      expect(page).to have_current_path(post_path(post))
      expect(page).to have_content("A post")
    end
  end

  context "when a user liked on current user's post" do
    it "received a comment notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:like, user: user_one, post:)

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_content("Jane Doe liked your post")
    end
  end

  context "when current user liked on his/her post" do
    it "will not send a notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:like, user: current_user, post:)
      create(:like, user: user_one, post:)

      visit root_path

      find(:test_id, "notifications-link").click

      expect(page).to have_content("Jane Doe liked your post")
      expect(page).not_to have_content("John Doe liked your post")
    end
  end

  context "when user clicked a like notif" do
    it "will redirect to the post page" do
      post = create(:post, user: current_user, content: "A post")
      create(:like, user: user_one, post:)
      notif = Notification.find_by(user_id: current_user.id)

      visit notifications_path

      find(:test_id, "notification_#{notif.id}").click

      expect(page).to have_current_path(post_path(post))
      expect(page).to have_content("A post")
    end
  end
end
