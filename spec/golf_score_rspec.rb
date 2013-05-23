require 'rspec'
require 'csv'

require_relative '../lib/golf_score'

describe HoleLayout  do
  let(:csv_file) { '../course_layout.csv' }
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
  let(:csv_file) { '../erick.csv' }
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
  let(:player) { PlayerScoreCard.new('../jasonz.csv') }
  let(:player_scorecard_array) { player.create_scorecard } 
  let(:player_score_card) { PlayerScoreCard.new('../jasonz.csv').create_scorecard }
  let(:hole_layout) { HoleLayout.new('../course_layout.csv') }
  let(:output_scorecard) { OutputScores.new(player_score_card, hole_layout) }

  it "gets the player's name" do 
    players_name = output_scorecard.get_players_names
    expect(players_name).to eql("#{player_scorecard_array[19].last} #{player_scorecard_array[18].last}")
  end

  it "outputs the players hole by hole scorecard" do
    expect(output_scorecard.scorecard_output).to eql("Hole 18: #{player_score_card.last.first} - #{}")
  end

  it "adds all the strokes into the final score" do
    total = player_score_card.flatten
    total.pop(2)
    total_score = 0
    total.each do |sum|
      total_score = total_score + sum.to_i
    end

    expect(output_scorecard.total_scores).to eql(total_score)
  end

  it "displays number of strokes in relation to par" do
    expect(output_scorecard.from_par).to eql(output_scorecard.total_scores - 72)
  end
end