class WeeklyRankingsController < ApplicationController
  skip_before_action :login_required
  before_action :admin_rights_required, except: [:index, :show]

  def index
    @weekly_ranking = WeeklyRanking.current
  end

  def show
    @weekly_ranking = WeeklyRanking.find(params[:id])
  end

  def new
    @weekly_ranking = WeeklyRanking.new(date: (Date.today + 1.week).beginning_of_week(:sunday))
  end

  def create
    creek = Creek::Book.new(weekly_ranking_params.fetch(:file).path)
    rows = creek.sheets[0].rows

    @weekly_ranking = WeeklyRanking.new(weekly_ranking_params.slice(:date))

    ActiveRecord::Base.transaction do
      @weekly_ranking.save!
      @weekly_ranking.parse!(rows)
    end

    redirect_to weekly_rankings_path, notice: 'De stand is bijgewerkt.'
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = 'De stand kon niet worden bijgewerkt.'
    render :new, status: :unprocessable_entity
  end

  def edit
    @weekly_ranking = WeeklyRanking.find(params[:id])
  end

  def update
    @weekly_ranking = WeeklyRanking.find(params[:id])
    @weekly_ranking.date = weekly_ranking_params.fetch(:date)

    ActiveRecord::Base.transaction do
      @weekly_ranking.save!

      if weekly_ranking_params[:file].present?
        creek = Creek::Book.new(weekly_ranking_params.fetch(:file).path)
        rows = creek.sheets[0].rows

        @weekly_ranking.contestant_rankings.destroy_all
        @weekly_ranking.team_rankings.destroy_all
        @weekly_ranking.player_rankings.destroy_all
        @weekly_ranking.parse!(rows)
      end
    end

    redirect_to weekly_ranking_path(@weekly_ranking), notice: 'De stand is bijgewerkt.'
  end

  def destroy
    WeeklyRanking.destroy(params[:id])
    redirect_to weekly_rankings_path, notice: 'De stand is verwijderd.'
  end

  private

  def weekly_ranking_params
    params.require(:weekly_ranking).permit(:date, :file)
  end
end
