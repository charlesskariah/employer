class EmployersController < ApplicationController
    before_action :authenticate_employer!
    
    def index
    end
    
    def edit
      @employer = Employer.find(params[:id])
    end
    
    def update 
      @employer = Employer.find(params[:id]) 
      if @employer.update_attributes(params.require(:employer).permit(:email, :country_code, :phone_number))
        flash[:notice] = "Successfully updated the Details"
        redirect_to edit_employer_path
      else
        flash[:error] = @employer.errors.full_messages[0]
        redirect_to edit_employer_path
      end
    end
    
    def resend_email_verification
      current_employer.create_email_verification
      respond_to do |format|
        format.js
      end
    end
    
    def resend_phone_verification
      current_employer.create_phone_number_verfication
      respond_to do |format|
        format.js
      end
    end
    
    def verify_phone
    end
    
    def verify_email
    end
    
    def validate_email_token
      token = params[:email_token]
      if !current_employer.email_verification.verified && token.present?
        current_employer.verify_email_token(token)
        flash[:notice] = "Successfully Verified your token"
        redirect_to verify_email_employer_path 
      else
        flash[:notice] = "Invalid token"
        redirect_to verify_email_employer_path 
      end
    end
    
    def validate_phone_token
      token = params[:phone_token]
      if !current_employer.phone_verification.verified && token.present?
        current_employer.verify_phone_token(token)
        flash[:notice] = "Successfully Verified your token"
        redirect_to verify_phone_employer_path 
      else
        flash[:notice] = "Invalid token"
        redirect_to verify_phone_employer_path 
      end

    end
    
end
