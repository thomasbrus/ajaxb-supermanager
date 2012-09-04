class SuperteamsController < ApplicationController
  def edit
  end

  def update
    flash[:notice] = "Superteam is opgeslagen!"
    render json: { status: 'success' } and return

    @errors = []
    positions = %w(player-a-1 player-b-1 player-b-2 player-b-3 player-b-4 player-c-1 player-c-2 player-c-3 player-d-1 player-d-2 player-d-3 coach bonusplayer)
    if (params.keys & positions) != positions 
      @errors << 'Je hebt niet alle posities ingevuld' 
    else
      total_amount = 0
      taken_clubs = []
      taken_players = []

      params.each do |key, value|
        next if %w(coach bonusplayer).include?(key) or !positions.include?(key) 
        Rails.logger.info [key, value].inspect
        total_amount += value[:amount].to_i
        taken_clubs << value[:club]
        taken_players << value[:player]
      end

      if total_amount > 36
        @errors << 'Je hebt het budget overschreden.'
      end

      if taken_players.uniq.length < taken_players.length
        @errors << 'Je mag een speler maar &eacute;&eacute;n keer opstellen.'
      elsif taken_clubs.uniq.length < taken_clubs.length
        @errors << 'Je mag per club maar &eacute;&eacute;n speler gebruiken.'
      end
    end

    if @errors.empty?
      superteam = Superteam.new      
      
      superteam.coach_id = params[:coach][:coach]
      superteam.bonus_player_id = params[:bonusplayer][:player]
      
      superteam.goalkeeper_id = params['player-a-1'][:player]

      superteam.defender_a_id = params['player-b-1'][:player]
      superteam.defender_b_id = params['player-b-2'][:player]
      superteam.defender_c_id = params['player-b-3'][:player]
      superteam.defender_d_id = params['player-b-4'][:player]

      superteam.midfielder_a_id = params['player-c-1'][:player]
      superteam.midfielder_b_id = params['player-c-2'][:player]
      superteam.midfielder_c_id = params['player-c-3'][:player]

      superteam.forward_a_id = params['player-d-1'][:player]
      superteam.forward_b_id = params['player-d-2'][:player]
      superteam.forward_c_id = params['player-d-3'][:player]

      superteam.contestant_id = @current_contestant.id

      @errors << superteam.errors.inspect unless superteam.save
    end

    if @errors.any?
      render json: { status: 'error', message: @errors }  
    else
      render json: { status: 'success' }, notice: "Superteam is opgeslagen!"
    end
  end
end
