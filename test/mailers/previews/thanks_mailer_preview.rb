# Preview all emails at http://localhost:3000/rails/mailers/thanks_mailer
class ThanksMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/thanks_mailer/user_thanks_mail
  def user_thanks_mail
    ThanksMailer.user_thanks_mail
  end

end
