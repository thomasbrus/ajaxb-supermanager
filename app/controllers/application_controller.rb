class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_contestant

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
      @contestant ||= Contestant.find(cookies.signed[:contestant_id]) if logged_in?
    end
end
