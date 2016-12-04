class UserMailer < ApplicationMailer
  def test(email)
    mail(:to => email, :subject => "Hello World!")
  end
end
