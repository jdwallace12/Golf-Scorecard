require 'rspec'
require 'csv'

require_relative '../lib/golf_score'

describe HoleLayout  do
  let(:csv_file) { 'course_layout.csv' }
  let(:course_holes) { HoleLayout.new(csv_file) }
  let(:course_array) { course_holes.create_course } 

  it 'creates 18 arrays 1 for each hole' do
    expect(course_array.count).to eql(18) 
  end
  it 'takes hole information from csv file and creates a nested array' do
    expect(course_array).to eql(CSV.read(csv_file))
  end
end

describe PlayerScoreCard do
  let(:csv_file) { 'jasonz.csv' }
  let(:player) { PlayerScoreCard.new(csv_file) }
  let(:player_scorecard_array) { player.create_scorecard } 

  it 'creates 20 arrays, 18 scores, first name, last name' do
    expect(player_scorecard_array.count).to eql(20)
  end
  it "takes the scores and player's name from a csv file and creates nested array." do
    expect(player_scorecard_array).to eql(CSV.read(csv_file))
  end
end
  
describe OutputScores do
  # let(:player) { PlayerScoreCard.new('../jasonz.csv') }
  # let(:player_scorecard_array) { player.create_scorecard } 
  let(:player_score_card) { PlayerScoreCard.new('jasonz.csv').create_scorecard }
  let(:hole_layout) { HoleLayout.new('course_layout.csv').create_course }
  let(:output_scorecard) { OutputScores.new(player_score_card, hole_layout) }

  it "gets the player's name" do 
    players_name = output_scorecard.get_players_names
    expect(players_name).to eql("#{player_score_card[19].last} #{player_score_card[18].last}")
  end

  it "outputs the players hole by hole score with correct term" do
    hole_by_hole_par = player_score_card[17].last.to_i - hole_layout[17].last.to_i
    if hole_by_hole_par == -2 && @hole_layout[17].last.to_i == 3
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
    expect(output_scorecard.scorecard_output).to eql("Hole 18: #{player_score_card[17].last} - #{hole_by_hole_par}")
  end

  it "adds all the strokes into the final score" do
    total = player_score_card.flatten.slice(0..17)
    total_score = 0
    total.each do |sum|
      total_score = total_score + sum.to_i
    end
    expect(output_scorecard.total_scores).to eql(total_score)
  end

  it "determines par for the course" do
    par = 0
    course_par = hole_layout.flatten
    course_par.each do |sum|
      par = par + sum.to_i
    end
    expect(output_scorecard.par_for_the_course).to eql(par)
  end

  it "displays number of strokes in relation to par" do
    if output_scorecard.total_scores - 72 == 0
      expect(output_scorecard.from_par).to eql("even par")
    elsif output_scorecard.total_scores - 72 > 0
      expect(output_scorecard.from_par).to eql("#{output_scorecard.total_scores - 72} over par")
    else
      expect(output_scorecard.from_par).to eql("#{(output_scorecard.total_scores - 72).abs} under par")
    end
  end
end