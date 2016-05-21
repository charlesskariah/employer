class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :phone_number, :country_code, presence: true
  
  has_one :phone_verification
  has_one :email_verification
  
  after_create :create_verification_tokens
  
  
  def create_verification_tokens
    create_email_verification
    create_phone_number_verfication
  end
  
  def create_email_verification
     #to reuse the method for requesting the unique_token again, we use find_or_initialize_by
    verification = EmailVerification.find_or_initialize_by(employer: self)
    verification.update_attributes(unique_token: random_string)
    EmployerMailer.send_token(self).deliver_now
  end
  
  def create_phone_number_verfication
    verification = PhoneVerification.find_or_initialize_by(employer: self)
    verification.update_attributes(unique_token: random_string)
    send_token
  end
  
  def send_token
    token = self.phone_verification.unique_token
    text = "Your verification code is #{token}.Please use the same for verify your mobile number"
    to_number = self.country_code + self.phone_number
    require 'nexmo'
    nexmo = Nexmo::Client.new(key: 'af9cc18a', secret: '158225e56ffd5b82')
    response = nexmo.send_message(from: '+919562141230', to: to_number, text: text )
    puts response
  end
    
    
  def email_verified
    self.email_verification.verified
  end
  
  def phone_verified
    self.phone_verification.verified
  end
      
  def random_string
    SecureRandom.hex(4)
  end

end
