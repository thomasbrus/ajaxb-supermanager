class PlayersController < ApplicationController
  skip_before_filter :login_required, only: [:index]

  def index
    player_types = { a: 'Goalkeeper', b: 'Defender', c: 'Midfielder', d: 'Forward' }

    @players = Player

    @players = Club.where('lower(shorthand) = ?', params[:club].downcase).first.players if params[:club].present?
    @players = @players.where(type: player_types[params[:position].to_sym]) if params[:position].present?
    @players = @players.where('value <= ?', params[:value]) if params[:value].present?

    @players = @players.order('value, name ASC')

    json = {}
    @players.each do |player|
      json["&euro;#{player.value} miljoen"] ||= {}
      json["&euro;#{player.value} miljoen"][player.id] = player.name
    end

    respond_to do |format|
      format.json { render json: json }
    end
  end
end
