require "rails_helper"

RSpec.describe "Commenting" do
  let!(:user) { create(:user, name: "John Doe") }
  let!(:friend_user) { create(:user, name: "Jane Doe") }

  before do
    create(:friend, user:, friend: friend_user)
    sign_in user
  end

  context "when user add a comment in a post" do
    it "display the comment in the post" do
      post = create(:post, user:, content: "Test 1")

      visit root_path

      expect(page).not_to have_selector('form textarea[placeholder="Write a comment..."]')

      find(:test_id, "comment-btn").click

      expect(page).to have_selector('form textarea[placeholder="Write a comment..."]')
    end
  end
end
