require "rails_helper"

RSpec.describe Notification do
  let!(:current_user) { create(:user, name: "Current User") }
  let!(:other_user) { create(:user, name: "Other User") }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:sender) }
  it { is_expected.to belong_to(:notifiable) }

  context "when user add a friend" do
    before do
      create(:friend, user: current_user, friend: other_user)
    end

    it "send a friend request notification" do
      friend = other_user.friends.find_by(friend_id: current_user.id)

      request_notif = described_class.find_by(user_id: other_user.id)

      expect(request_notif).not_to be_nil
      expect(request_notif.status).to eq("unseen")
      expect(request_notif.notifiable.friend).to eq(current_user)
    end
  end

  context "when user accept a friend request" do
    before do
      create(:friend, user: current_user, friend: other_user)
    end

    it "send a accept request notification" do
      friend = other_user.friends.find_by(friend_id: current_user.id)
      friend.update(status: 1)

      accept_request = described_class.find_by(user_id: current_user.id)

      expect(accept_request).not_to be_nil
      expect(accept_request.user).to eq(current_user)
      expect(accept_request.notifiable.user).to eq(other_user)
    end
  end

  context "when a user comment to a post" do
    it "send a comment notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:comment, user: other_user, post:, content: "A comment")

      comment_notif = described_class.find_by(user_id: current_user.id)

      expect(comment_notif).not_to be_nil
      expect(comment_notif.user.name).to eq(current_user.name)
    end
  end

  context "when a user liked a post" do
    it "send a like notification" do
      post = create(:post, user: current_user, content: "A post")
      create(:like, user: other_user, post:)

      like_notif = described_class.find_by(user_id: current_user.id)

      expect(like_notif).not_to be_nil
      expect(like_notif.user.name).to eq(current_user.name)
    end
  end
end
