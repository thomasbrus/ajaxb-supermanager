class Validators::FormationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    #...
  end
  # FORMATION = [
  #   GoalKeeper,
  #   Defender, Defender, Defender, Defender,
  #   Midfielder, Midfielder, Midfielder,
  #   Forward, Forward, Forward,
  # ]
end