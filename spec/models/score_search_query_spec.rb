require 'rails_helper'

describe ScoreSearchQuery, type: :model do
  fixtures :scores

  describe '#to_scope' do
    it 'returns all records if player, before, after are nil' do
      scores = ScoreSearchQuery.new(
        player: nil,
        before: nil,
        after: nil
      ).to_scope.to_a

      expect(scores.to_set).to eq(Score.all.to_set)
    end

    it 'works for complex query' do
      scores = ScoreSearchQuery.new(
        player: 'bob',
        before: '2021-04-02 00:00:00',
        after: '2021-04-02 00:00:00'
      ).to_scope.to_a
      expect(scores.size).to be(1)
    end
  end
end
