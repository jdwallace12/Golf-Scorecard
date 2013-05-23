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

  def initialize(player_score_card)
    @player_score_card = player_score_card
    # @hole_layout = hole_layout
  end

  def get_players_names
    first_name = @player_score_card.pop
    last_name = @player_score_card.pop
    "#{first_name} #{last_name}"
  end

  # def scorecard_output
  #   hole_number = 0
  #   @player_score_card.each do |hole_score|
  #     puts "Hole #{(hole_number + 1)}: #{hole_score} - #{not_sure_yet}"
  #     hole_number +=1
  #     "Hole #{(hole_number + 1)}: #{hole_score} - #{not_sure_yet}"
  #   end
  # end


end




puts 


