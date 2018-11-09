require "rails_helper"

describe "Movies API" do
  it 'get a list of movies' do
    2.times {create(:movie)}

    get '/api/v2/movies'

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(json['data'].size).to eq 2
  end

  it 'row should have id and title' do
    movie = create(:movie)

    get "/api/v2/movies/#{movie.id}"

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(json['data']['id']).to eq movie.id.to_s
    expect(json['data']['attributes']['title']).to eq movie.title
    expect(json['data']['attributes']['genre-id']).to eq movie.genre.id
    expect(json['data']['attributes']['genre-name']).to eq movie.genre.name
    expect(json['data']['attributes']['genre-count']).to eq movie.genre.movies.size
  end

  it 'should return 404 when resource dont exists' do

    get "/api/v1/movies/123"

    expect(response).to have_http_status(404)
  end
end