class SuperteamsController < ApplicationController
  def edit
  end

  def update
    collect_errors

    # Save superteam if any positions are provided
    if (params.keys & positions).any?
      superteam = @current_contestant.superteam || Superteam.new

      superteam.coach_id = params.dig(:coach, :coach)
      superteam.bonus_player_id = params.dig(:bonusplayer, :player)

      superteam.goalkeeper_id = params.dig('player-a-1', :player)

      superteam.defender_a_id = params.dig('player-b-1', :player)
      superteam.defender_b_id = params.dig('player-b-2', :player)
      superteam.defender_c_id = params.dig('player-b-3', :player)
      superteam.defender_d_id = params.dig('player-b-4', :player)

      superteam.midfielder_a_id = params.dig('player-c-1', :player)
      superteam.midfielder_b_id = params.dig('player-c-2', :player)
      superteam.midfielder_c_id = params.dig('player-c-3', :player)

      superteam.forward_a_id = params.dig('player-d-1', :player)
      superteam.forward_b_id = params.dig('player-d-2', :player)
      superteam.forward_c_id = params.dig('player-d-3', :player)

      superteam.contestant_id = @current_contestant.id

      @errors += superteam.errors.full_messages unless @errors.empty? && superteam.valid?

      superteam.save(validate: false)
    end

    if @errors.any?
      render json: { status: 'error', message: @errors }
    else
      flash[:notice] = "Superteam is opgeslagen! Je kunt het team op elk moment tot de sluitingsdatum wijzigen."
      render json: { status: 'success' }
    end
  end

  def validate
    collect_errors

    superteam = @current_contestant.superteam || Superteam.new
    @errors += superteam.errors.full_messages unless @errors.empty? && superteam.valid?

    if @errors.any?
      render json: { status: 'error', message: @errors }
    else
      render json: { status: 'success' }
    end
  end

  def show
    !superteam = @current_contestant.superteam

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

  private

  def collect_errors
    @errors = []

    if (params.keys & positions) != positions
      @errors << 'Je hebt niet alle posities ingevuld'
    else
      total_amount = 0
      taken_clubs = []
      taken_players = []

      begin
        bonusplayer = Player.find(params[:bonusplayer][:player])
        @errors << 'De bonusspeler is te duur, hij mag maximaal 2 miljoen kosten.' if bonusplayer.value > 2
      rescue ActiveRecord::RecordNotFound
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
        @errors << 'De volgende speler(s) zijn vaker opgesteld:'
        @errors << taken_players.keep_if { |id| taken_players.count(id) > 1 }.uniq.map { |player_id|
          Player.find(player_id).name
        }.join(', ')
      elsif taken_clubs.uniq.length < taken_clubs.length
        @errors << 'Je mag per club maar &eacute;&eacute;n speler gebruiken.'
        @errors << 'De volgende club(s) zijn vaker gebruikt:'
        @errors << taken_clubs.keep_if { |id| taken_clubs.count(id) > 1 }.uniq.map { |club_shorthand|
          Club.where('lower(shorthand) = ?', club_shorthand.downcase).first.name
        }.join(', ')
      end
    end
  end

  def positions
    %w(player-a-1 player-b-1 player-b-2 player-b-3 player-b-4 player-c-1 player-c-2 player-c-3 player-d-1 player-d-2 player-d-3 coach bonusplayer)
  end
end
