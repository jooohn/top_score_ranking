class HistoriesController < ApplicationController

  def show
    history = Score.history(params.require(:player))
    render json: history
  end

end
