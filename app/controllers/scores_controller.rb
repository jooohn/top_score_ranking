class ScoresController < ApplicationController
  DEFAULT_SEARCH_PARAMS = {
    limit: 20,
  }

  def index
    scores = ScoreSearchQuery.new(search_params).to_scope.to_a
    render json: scores
  end

  def show
    @score = Score.find(params.require(:id))
    render json: @score
  end

  def create
    score = Score.new(params.permit(:player, :score, :time))
    if score.save
      render json: score
    else
      render status: 400, json: { errors: score.errors }
    end
  end

  def destroy
    @score = Score.find(params.require(:id))
    @score.destroy!
    render head: 200
  end

  private

  def search_params
    DEFAULT_SEARCH_PARAMS.merge(params.permit(:player, :before, :after, :offset))
  end
end
