class ThanksMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.thanks_mailer.user_thanks_mail.subject
  #
  def user_thanks_mail(user)
  	@user = user
    mail(to: @user.email, subject: 'Welcome to Our Application!')
  end
end
