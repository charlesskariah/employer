class EmployersController < ApplicationController
    before_action :authenticate_employer!
    
    def index
    end
    
    def edit
      @employer = Employer.find(params[:id])
    end
    
    def update 
      @employer = Employer.find(params[:id]) 
      if @employer.update_attributes(params.require(:employer).permit(:email)) 
        redirect_to edit_employer_path, :flash => { :success => "success" }
      else
        flash[:error] = @employer.errors.full_messages[0]
        redirect_to edit_employer_path
      end
   end
    
end
