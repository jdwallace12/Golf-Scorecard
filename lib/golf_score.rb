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
    hole_layout_index_count = 0
    @player_score_card.slice(0..17).each_with_index do |hole_score, index|
      each_hole_par = @hole_layout[hole_layout_index_count].first.to_i
      hole_by_hole_par =  hole_score.first.to_i - each_hole_par
      if hole_by_hole_par == -2 && @hole_layout[hole_layout_index_count] == 3
        hole_by_hole_par == "Ace"
      elsif hole_by_hole_par == -2
        hole_by_hole_par = "Eagle"
      elsif hole_by_hole_par == -1
        hole_by_hole_par = "Birdie"
      elsif hole_by_hole_par == 0
        hole_by_hole_par = "Par"
      elsif hole_by_hole_par == 1
        hole_by_hole_par = "Bogie"
      elsif hole_by_hole_par == 2
        hole_by_hole_par = "Double Bogie"
      elsif hole_by_hole_par == 3
        hole_by_hole_par = "Triple Bogie"
      else
        return hole_by_hole_par.to_s 
      end
      hole_layout_index_count += 1
      hole_number = index + 1
      output = "Hole #{(hole_number)}: #{hole_score.first} - #{hole_by_hole_par}"
      puts "Hole #{(hole_number)}: #{hole_score.first} - #{hole_by_hole_par}"
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

course = HoleLayout.new('course_layout.csv').create_course
score_card = PlayerScoreCard.new('jasonz.csv').create_scorecard
printed_scorecard = OutputScores.new(score_card, course)
printed_scorecard.scorecard_output
