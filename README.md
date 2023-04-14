# FriendsZone

A Facebook-clone built with Ruby on Rails. This is the final project for Ruby on Rails course in [TheOdinProject](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project). This app will have the core features of Facebook - users, profiles, friends, posting, likes, comments, notifications.

You can sign-up to [Live Preview](https://friendszone.up.railway.app/) or log-in using this account:

- username: `sampleuser`
- email: `sample@user.com`
- password: `password`

## Features

- User

  - used [Devise](https://github.com/heartcombo/devise) gem to create users with authentications.

  - omniauth in devise was also implemented to allow user to log-in with their facebook account (but this is only available in development environment only since facebook needs a provicy policy to make the app live which I don't have at the moment).

- Profiles

  - user can edit and delete their account in their profile page.

  - sampleuser update button is disabled to prevent it to be edited or deleted.

- Friends

  - user can add friends in the Find Friends page.

  - after adding, the requested friends will be removed from the list and will be added to users friends a.k.a followed friends.

  - user can cancel request the request, delete other's request and unfriend.

- Posts, Likes, Comments

  - user can make a text post which will only be visible only to those who follows the user.

  - used hotwire - turbo-frame to render the post and comment form in the root path

  - used hotwire - turbo-stream to prepend new post and comments, change the counter of likes and comments

- Notifications

  - a notifications will be sent when user receive a friends request, accept request, likes and comments a post.

  - a polymorphic association was used for this so friends, likes, comments can have notifications.

## Testing

- used [rspec-rails](https://github.com/rspec/rspec-rails), [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails), [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) and capybara for testing

- testing covers the following:
  - models - for associations, validations, methods in model
  - features - for integration
  - request - for response and redirect

## Other gem used

- [faker](https://github.com/faker-ruby/faker) - to populate database

- [figaro](https://github.com/laserlemon/figaro) - for env variables

- [tailwindcss-rails](https://github.com/rails/tailwindcss-rails) - for styling

- [letter-opener](https://github.com/ryanb/letter_opener) - to preview mails in development environment

- [rubocop](https://github.com/rubocop/rubocop), [rubocop-performance](https://github.com/rubocop/rubocop-performance), [rubocop-rails](https://github.com/rubocop/rubocop-rails), [rubocop-rspec](https://github.com/rubocop/rubocop-rspec) - as linter

## Future Improvements

- Facebook login in production
- Add more details to the users, e.g. birthday
- Allow user to upload a profile photo
- Allow user to post an image
- ~~Implement mailer in production~~
