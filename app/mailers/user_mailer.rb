class UserMailer < ApplicationMailer
  def welcome_mailer(user)
    @user = user

    mail to: @user.email, subject: I18n.t("welcome_mailer.subject")
  end
end
