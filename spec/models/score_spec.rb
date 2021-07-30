require 'rails_helper'

describe Score, type: :model do
  fixtures :scores

  bob_time_1 = DateTime.new(2021, 4, 1)
  bob_time_2 = DateTime.new(2021, 4, 2)
  bob_time_3 = DateTime.new(2021, 4, 3)

  it 'normalizes name before save' do
    scores = ['Bob', 'bob', 'BOB'].map { |player|
      score = Score.new(player: player, score: 100, time: Time.current)
      score.save!
      score.reload
    }
    expect(scores.map(&:player).to_set).to eq(Set['bob'])
  end

  describe '#player' do
    it 'returns scores of given player' do
      scores = Score.player('bob').to_a
      expect(scores.map(&:player).to_set).to eq(Set['bob'])
    end

    it 'accepts multiple player names' do
      scores = Score.player(['bob', 'alice']).to_a
      expect(scores.map(&:player).to_set).to eq(Set['bob', 'alice'])
    end
  end

  describe '#before' do
    it 'returns items scored at or before the given time' do
      scores = Score.player('bob').before(bob_time_2).to_a
      expect(scores.map(&:time).sort).to eq([bob_time_1, bob_time_2])
    end
  end

  describe '#after' do
    it 'returns items scored at or after the given time' do
      scores = Score.player('bob').after(bob_time_2).to_a
      expect(scores.map(&:time).sort).to eq([bob_time_2, bob_time_3])
    end
  end
end
