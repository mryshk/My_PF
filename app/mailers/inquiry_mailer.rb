class InquiryMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(to: inquiry.email, subject: 'お問い合わせを承りました。')
  end
end
