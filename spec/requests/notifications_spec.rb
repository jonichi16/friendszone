require "rails_helper"

RSpec.describe "Notifications" do
  context "when user clicked a friend request notification" do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      sign_in current_user
      create(:friend, user: other_user, friend: current_user)
    end

    it "redirects to the user page" do
      notif = Notification.find_by(user_id: current_user)

      get update_notif_path(notif)
      expect(response).to redirect_to(user_path(other_user))
    end
  end
end
