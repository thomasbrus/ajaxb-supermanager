class SessionsController < ApplicationController
  def destroy
    logout and redirect_to root_path
  end
end
