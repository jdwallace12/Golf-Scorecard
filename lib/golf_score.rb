require 'csv'

class HoleLayout

  def initialize(csv_file)
    @csv_file = csv_file
  end

  def create_course
    course_layout_array = CSV.read(@csv_file)
  end
end


class PlayerScoreCard
 
  def initialize(csv_file)
    @csv_file = csv_file
  end

  def create_scorecard
    player_scorecard_array = CSV.read(@csv_file)
  end
end







class OutputScores

  def initialize(player_score_card, hole_layout)
    @player_score_card = player_score_card
    @hole_layout = hole_layout
  end

  def get_players_names
    first_name = @player_score_card.pop
    last_name = @player_score_card.pop
    "#{first_name} #{last_name}"
  end

  def scorecard_output
    output = ""
    @player_score_card.pop(2)
    @player_score_card.each_with_index do |hole_score, index|
      hole_number = index + 1
      output = "Hole #{(hole_number)}: #{hole_score.first} - #{}"
      puts "Hole #{(hole_number)}: #{hole_score.first} - #{}"
    end

    output
  end
end

