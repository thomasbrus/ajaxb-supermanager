class SuperteamsController < ApplicationController
  def edit
  end

  def update
    @errors = []
    positions = %w(player-a-1 player-b-1 player-b-2 player-b-3 player-b-4 player-c-1 player-c-2 player-c-3 player-d-1 player-d-2 player-d-3 coach bonusplayer)
    if (params.keys & positions) != positions 
      @errors << 'Je hebt niet alle posities ingevuld' 
    else
      total_amount = 0
      taken_clubs = []
      taken_players = []

      puts params.inspect
      bonusplayer = Player.find(params[:bonusplayer][:player])

      if bonusplayer.value > 2
        @errors << 'De bonusspeler is te duur, hij mag maximaal 2 miljoen kosten.'
      end

      params.each do |key, value|
        next if key == "coach" or !positions.include?(key) 
        total_amount += value[:amount].to_i unless key == "bonusplayer"
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
      superteam =  @current_contestant.superteam || Superteam.new
      
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
      flash[:notice] = "Superteam is opgeslagen! Je kunt het team op elk moment tot de sluitingsdatum wijzigen."
      render json: { status: 'success' }
    end
  end

  def show
    superteam = @current_contestant.superteam

    if superteam.nil?
      render json: {} and return
    end

    mapping = {
      bonus_player: 'bonusplayer',
      coach: 'coach',
      goalkeeper: 'player-a-1',
      defender_a: 'player-b-1',
      defender_b: 'player-b-2',
      defender_c: 'player-b-3',
      defender_d: 'player-b-4',
      midfielder_a: 'player-c-1',
      midfielder_b: 'player-c-2',
      midfielder_c: 'player-c-3',
      forward_a: 'player-d-1',
      forward_b: 'player-d-2',
      forward_c: 'player-d-3'
    }

    positions_mapping = {
      Goalkeeper: 'a',
      Defender: 'b',
      Midfielder: 'c',
      Forward: 'd'
    }

    json = {}
    mapping.each do |accessor, mapping|
      pos = superteam.send(accessor)
      next if pos.nil?
      json[mapping] = {
        club: pos.club.shorthand.downcase,
        name: pos.name,
        id: pos.id
      }
      unless pos.is_a? Coach
        json[mapping] = json[mapping].merge({
          position: positions_mapping[pos.type.to_sym],
          value: pos.value
        })
      end
    end

    render json: json
  end
end
