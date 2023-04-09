class UserMailer < ApplicationMailer
  default from: "registrations@friendszone.com"

  def welcome_mailer(user)
    @user = user

    mail to: @user.email, subject: I18n.t("welcome_mailer.subject")
  end
end
