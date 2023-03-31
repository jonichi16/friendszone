require "rails_helper"

RSpec.describe "Users" do
  let(:user) { create(:user) }

  describe "user requesting users_path" do
    context "when user is signed in" do
      before do
        sign_in user
      end

      it "renders the users_path" do
        get users_path
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not signed in" do
      it "redirects to the users sign-in page" do
        get users_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
