require "rails_helper"

RSpec.describe Comment do
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }
end
