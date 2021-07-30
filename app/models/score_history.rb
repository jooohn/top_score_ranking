class ScoreHistory
  include ActiveModel::Model

  attr_accessor :top_score,
                :low_score,
                :average,
                :scores

  class << self

    def from_scores(scores)
      statistics = scores.each_with_object({ sum: 0, min: nil, max: nil }) do |score, acc|
        acc[:sum] += score.score
        acc[:low_score] = [acc[:low_score], score].compact.min_by(&:score)
        acc[:top_score] = [acc[:top_score], score].compact.max_by(&:score)
      end
      new(
        top_score: statistics[:top_score],
        low_score: statistics[:low_score],
        average: scores.empty? ? nil : statistics[:sum] / scores.size,
        scores: scores
      )
    end

  end

end
