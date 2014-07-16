class MyDeviseMailer < Devise::Mailer

  default from: 'My App <www.example.com>'

  def question_notification(answer)
  	@answer = answer
    mail(:to => answer.question.user.email).deliver!
  end

  def answer_accept_notification(answer)
  	@answer = answer
    mail(:to => answer.user.email).deliver!
  end

end