class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :phone_number, :country_code, presence: true
  
  after_create :send_verification_token
  
  def send_verification_token
    EmployerMailer.welcome_email(self).deliver_now
  end
    
end
