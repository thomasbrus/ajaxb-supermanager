module Admin
  class LoginRequestsController < ApplicationController
    before_action :admin_rights_required

    def new
      @login_request = LoginRequest.new
    end

    def create
      @login_request = LoginRequest.new(login_request_params)

      if @login_request.save
        redirect_to admin_login_request_url(@login_request), notice: 'Inloglink aangemaakt.'
      else
        render action: 'new'
      end
    end

    def show
      @login_request = LoginRequest.find(params[:id])
    end

    private

    def login_request_params
      params.require(:login_request).permit(:contestant_id)
    end
  end
end
