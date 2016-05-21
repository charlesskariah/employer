class EmployerMailer < ApplicationMailer
  default from: 'test@example.com'
 
  def welcome_email(employer)
    @employer = employer
    @unique_token = employer.email_verification.unique_token
    mail(to: @employer.email, subject: 'Welcome to Employer Portal')
  end
  
  def send_token(employer)
    @employer = employer
    @unique_token = employer.email_verification.unique_token
    mail(to: @employer.email, subject: 'Verification Token for email')
  end
  
end
