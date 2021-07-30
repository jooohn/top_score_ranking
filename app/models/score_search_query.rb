class ScoreSearchQuery
  include ActiveModel::Model
  attr_accessor :player,
                :before,
                :after,
                :offset,
                :limit

  def to_scope
    Score.all.
      yield_self { |scope| before.nil? ? scope : scope.before(before) }.
      yield_self { |scope| after.nil? ? scope : scope.after(after) }.
      yield_self { |scope| player.nil? ? scope : scope.player(player) }.
      offset(offset).limit(limit).order(:time)
  end
end
