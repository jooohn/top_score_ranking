require 'rails_helper'

RSpec.describe "Histories", type: :request do
  describe "GET /" do

    it 'returns score history of player' do
      get '/players/bob/history'
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body).to have_key('top_score')
      expect(body).to have_key('low_score')
      expect(body).to have_key('average')
      expect(body).to have_key('scores')
    end

  end
end
