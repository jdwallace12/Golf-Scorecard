require 'csv'
require 'pry'

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
    first_name = @player_score_card.slice(19)
    last_name = @player_score_card.slice(18)
    "#{first_name[0]} #{last_name[0]}"
  end

  def scorecard_output
    output = ""
    puts self.get_players_names
    @player_score_card.slice(0..17).each_with_index do |hole_score, index|
      hole_number = index + 1
      output = "Hole #{(hole_number)}: #{hole_score.first} - #{}"
      puts "Hole #{(hole_number)}: #{hole_score.first} - #{}"
    end
    puts "\n\nTotal score: #{self.total_scores}"
    puts self.from_par

    output
  end

  def total_scores
    total_score = 0
    card = @player_score_card.flatten
    card.slice(0..17).each do |sum|
      total_score = total_score + sum.to_i
    end

    total_score
  end

  def par_for_the_course
    par = 0
    course_par = @hole_layout.flatten
    course_par.each do |sum|
      par = par + sum.to_i
    end

    par
  end


  def from_par
    to_par = self.total_scores - self.par_for_the_course
    if to_par == 0
      return "even par"
    elsif to_par > 0
      return "#{to_par} over par"
    else
      return "#{to_par.abs} under par"
    end
  end
end

