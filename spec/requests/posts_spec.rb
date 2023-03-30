require "rails_helper"

RSpec.describe "Posts" do
  context "when user is signed in" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "renders the root_path" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  context "when user is not signed in" do
    it "redirects to the users sign-in page" do
      get root_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
