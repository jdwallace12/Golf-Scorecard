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
  let(:csv_file) { '../erick.csv' }
  let(:player) { PlayerScoreCard.new(csv_file) }
  let(:player_scorecard_array) { player.create_scorecard } 
  let(:player_score_card) { PlayerScoreCard.new(csv_file).create_scorecard }

  it "prints the player's name" do 
    output_scorecard = OutputScores.new(player_score_card)
    players_name = output_scorecard.get_players_names
    expect(players_name).to eql("#{player_scorecard_array[19]} #{player_scorecard_array[18]}")
  end
end