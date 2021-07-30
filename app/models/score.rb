class Score < ApplicationRecord
  validates :player, presence: true
  before_save :normalize_player

  validates :score, presence: true
  validates :time, presence: true

  scope :player, lambda { |player| where(player: player) }
  scope :before, lambda { |time| where('time <= ?', time) }
  scope :after, lambda { |time| where('? <= time', time) }

  def normalize_player
    self.player = player.downcase
  end

  class << self

    def history(player)
      scores = self.player(player).to_a
      ScoreHistory.from_scores(scores)
    end

  end
end
