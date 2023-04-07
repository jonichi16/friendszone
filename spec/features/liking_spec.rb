require "rails_helper"

RSpec.describe "Liking" do
  let!(:current_user) { create(:user, name: "John Doe") }

  before do
    sign_in current_user
  end

  context "when current user's post was liked" do
    it "increased the like counter" do
      post = create(:post, user: current_user)

      visit root_path

      expect(find(:test_id, "post_#{post.id}-likes-counter").text).to eq("0")

      find(:test_id, "post_#{post.id}-like-btn").click

      expect(find(:test_id, "post_#{post.id}-likes-counter").text).to eq("1")
    end
  end

  context "when current user's post was unliked" do
    it "decreased the like counter" do
      post = create(:post, user: current_user)
      create(:like, user: current_user, post:)

      visit root_path

      expect(find(:test_id, "post_#{post.id}-likes-counter").text).to eq("1")

      find(:test_id, "post_#{post.id}-dislike-btn").click

      expect(find(:test_id, "post_#{post.id}-likes-counter").text).to eq("0")
    end
  end
end
