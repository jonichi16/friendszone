source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "7.0.6"

gem "bootsnap", require: false
gem "devise"
gem "faker"
gem "figaro"
gem "importmap-rails"
gem "jbuilder"
gem "omniauth-facebook"
gem "omniauth-rails_csrf_protection"
gem "pg", "~> 1.5"
gem "puma", "~> 6.3"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.0"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :test do
  gem "capybara", "~> 3.38"
  gem "shoulda-matchers", "~> 5.3"
  gem "webdrivers", "~> 5.2"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
end

group :development do
  gem "letter_opener"
  gem "rubocop", "~> 1.54", ">= 1.54.1", require: false
  gem "rubocop-performance", "~> 1.18", require: false
  gem "rubocop-rails", "~> 2.20", require: false
  gem "rubocop-rspec", "~> 2.22", require: false
  gem "web-console"
end
