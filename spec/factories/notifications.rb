FactoryBot.define do
  factory :notification do
    user { nil }
    sender { nil }
    status { 1 }
  end
end
