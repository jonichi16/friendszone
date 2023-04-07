require "rails_helper"

RSpec.describe Like do
  let!(:current_user) { create(:user) }
  let!(:other_user) { create(:user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  context "when a user liked a post" do
    it "allow to like the post" do
      post = create(:post, user: current_user)

      like = post.likes.create(user: other_user)

      expect(like).not_to be_nil
    end
  end
end
