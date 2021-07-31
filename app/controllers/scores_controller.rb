class ScoresController < ApplicationController
  DEFAULT_SEARCH_PARAMS = {
    limit: 20,
  }.with_indifferent_access

  def index
    scores = ScoreSearchQuery.new(search_params).to_scope.to_a
    render json: scores
  end

  def show
    @score = Score.find_by(id: params.require(:id))
    return head 404 if @score.blank?

    render json: @score
  end

  def create
    score = Score.new(params.permit(:player, :score, :time))
    if score.save
      render status: 201, json: score
    else
      render status: 400, json: { errors: score.errors }
    end
  end

  def destroy
    @score = Score.find_by(id: params.require(:id))
    return head 404 if @score.blank?

    @score.destroy!
    render head: 200
  end

  private

  def search_params
    DEFAULT_SEARCH_PARAMS.merge(params.permit(:player, :before, :after, :offset))
  end
end
