require "rails_helper"

describe "Movies API" do
  it 'get a list of movies' do
    2.times {create(:movie)}

    get '/api/v1/movies'

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(json['data'].size).to eq 2
  end

  it 'api row should have id and title' do
    movie = create(:movie)

    get "/api/v1/movies/#{movie.id}"

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(json['data']['id']).to eq movie.id.to_s
    expect(json['data']['attributes']['title']).to eq movie.title
  end

  it 'api should 404 when resource dont exists' do

    get "/api/v1/movies/123"

    expect(response).to have_http_status(404)
  end
end