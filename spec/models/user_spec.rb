require "rails_helper"

RSpec.describe User do
  it { is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity }
  it { is_expected.to allow_value("example@example.com").for(:email) }
  it { is_expected.not_to allow_value("bademail").for(:email) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:friends).dependent(:destroy) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
end
