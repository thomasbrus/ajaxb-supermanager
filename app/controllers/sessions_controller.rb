class SessionsController < ApplicationController
  def destroy
    logout and redirect_to root_path, notice: "U bent nu uitgelogd."
  end
end
