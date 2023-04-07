require "rails_helper"

RSpec.describe Like do
  subject(:likes) { create(:like, user: current_user, post:) }

  let!(:current_user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: current_user) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  context "when a user liked a post" do
    it "allow to like the post" do
      like = post.likes.create(user: other_user)

      expect(like).not_to be_nil
    end
  end
end
