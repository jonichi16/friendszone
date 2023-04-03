require "rails_helper"

RSpec.describe Friend do
  subject(:friends) { create(:friend, user: friendship_user, friend: friendship_friend) }

  let(:friendship_user) { create(:user) }
  let(:friendship_friend) { create(:user) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:friend_id) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  context "when user add a friend" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      user.friends.create(friend_id: other_user.id)
    end

    it "create a reciprocal friend" do
      friendship = described_class.find_by(user_id: user.id)
      reciprocal_friendship = described_class.find_by(user_id: other_user.id)

      expect(friendship).not_to be_nil
      expect(reciprocal_friendship).not_to be_nil
      expect(reciprocal_friendship.status).to eq("pending")
    end
  end

  context "when user cancel a friend request" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      user.friends.create(friend_id: other_user.id)
    end

    it "destroy the reciprocal friend" do
      friendship = described_class.find_by(user_id: user.id)
      reciprocal_friendship = described_class.find_by(user_id: other_user.id)

      user.friends.destroy(friendship)

      expect(user.friends).to be_empty
      expect(other_user.friends).to be_empty
    end
  end
end
