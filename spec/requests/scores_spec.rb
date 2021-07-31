require 'rails_helper'

RSpec.describe "Scores", type: :request do
  fixtures :scores

  describe "GET /index" do

    it 'returns scores' do
      get '/scores'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to be(4)
    end

    it 'accepts query parameter' do
      get '/scores', params: {
        before: '2021-04-01 00:00:00',
        after: '2021-04-01 00:00:00',
        player: 'bob'
      }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to be(1)
    end

  end

  describe 'GET /scores/:id' do

    it 'finds score' do
      score = Score.first
      get "/scores/#{score.id}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["score"]).to be(score.score)
    end

    it 'returns 404 if not found' do
      get "/scores/non-existent"
      expect(response).to have_http_status(:not_found)
    end

  end

  describe 'POST /' do

    it 'rejects if parameter is insufficient' do
      expect {
        post '/scores', params: {
          score: 130,
          player: 'bob',
          time: '2021-04-04 00:00:00',
        }
      }.to change { Score.count }.by(1)
      expect(response).to have_http_status(:created)
    end

    it 'rejects if parameter is insufficient' do
      expect {
        post '/scores', params: {
          score: 130,
          player: 'bob',
        }
      }.not_to change { Score.count }
      expect(response).to have_http_status(400)
    end

  end

  describe 'DELETE /scores/:id' do

    it 'deletes existing score' do
      score = Score.first
      expect {
        delete "/scores/#{score.id}"
      }.to change { Score.count }.by(-1)

      expect { score.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns 404 if not exist' do
      delete '/scores/non-existent'
      expect(response).to have_http_status(:not_found)
    end
  end

end
