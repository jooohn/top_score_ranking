require 'rails_helper'

describe ScoreHistory, type: :model do
  fixtures :scores

  describe 'from_scores' do

    it 'builds score history correctly' do
      bob_scores = Score.player('bob')
      history = ScoreHistory.from_scores(bob_scores)

      sorted_scores = bob_scores.sort_by(&:score)
      expect(history.top_score).to eq(sorted_scores.last)
      expect(history.low_score).to eq(sorted_scores.first)
      expect(history.average).to eq(110)
      expect(history.scores).to eq(bob_scores)
    end

  end

end
