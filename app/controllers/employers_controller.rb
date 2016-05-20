class EmployersController < ApplicationController
    before_action :authenticate_employer!
    
    def index
    end
    
end
