class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_contestant
  before_filter :login_required

  def login(contestant)
    cookies.signed[:contestant_id] = { value: contestant.id, expires: 1.month.from_now }
  end

  def logout
    cookies.delete(:contestant_id)
  end

  def logged_in?
    cookies.signed[:contestant_id].present?
  end

  def is_admin?
    if logged_in?
      fetch_contestant.is_admin
    else
      false
    end
  end

  helper_method :logged_in?
  helper_method :is_admin?

  private
    def fetch_contestant
      begin
        @current_contestant ||= Contestant.find(cookies.signed[:contestant_id]) if logged_in?
      rescue ActiveRecord::RecordNotFound
        logout
      end
    end

    def login_required
      unless logged_in?
        flash[:alert] = "Om deze pagina te bekijken moet u ingelogd zijn."
        redirect_to(root_path)
      end
    end

    def admin_rights_required
      unless is_admin?
        flash[:alert] = "Om deze actie uit te voeren moet u administratorrechten hebben."
        redirect_to(root_path)
      end
    end
end
