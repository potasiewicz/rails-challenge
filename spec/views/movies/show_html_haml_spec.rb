require "rails_helper"

describe "movies/show.html.haml" do
  before(:each) do
    allow(controller).to receive(:user_signed_in?).and_return(true)
  end

  it "display rating" do
    assign(:movie, OpenStruct.new(rating: '9.2', comments: []))

    render

    expect(rendered).to have_selector("span.badge", text: '9.2')
  end

  it "display plot" do
    assign(:movie, OpenStruct.new(plot: 'plot information', comments: []))

    render

    expect(rendered).to have_selector("div", text: 'plot information')
  end

  it "display cover" do
    assign(:movie, OpenStruct.new(cover: 'http://movie.image.com', comments: []))

    render

    expect(rendered).to match /http:\/\/movie.image.com/
  end
end