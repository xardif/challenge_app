class MyDeviseMailer < Devise::Mailer

  default from: 'My App <mailer@example.com>'

  def question_notification(answer)
  	@answer = answer
    mail(:to => 'xardif@gmail.com').deliver
  end

  def answer_accept_notification(answer)
  	@answer = answer
    mail(:to => answer.user.email).deliver
  end

end