require "rails_helper"

RSpec.describe Friend do
  subject(:friends) { create(:friend, user: friendship_user, friend: friendship_friend) }

  let(:friendship_user) { create(:user) }
  let(:friendship_friend) { create(:user) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:friend_id) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }
end
