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

  helper_method :logged_in?

  private
    def fetch_contestant
      begin
        @current_contestant ||= Contestant.find(cookies.signed[:contestant_id]) if logged_in?
      rescue ActiveRecord::RecordNotFound
        logout
      end
    end

    def login_required
      redirect_to(root_path, alert: "Om deze pagina te bekijken moet u ingelogd zijn.") unless logged_in?
    end
end
