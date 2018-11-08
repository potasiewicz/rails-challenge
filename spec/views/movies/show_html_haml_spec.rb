require "rails_helper"

describe "movies/show.html.haml" do
  before(:each) do
    allow(controller).to receive(:user_signed_in?).and_return(true)
  end

  it "displays rating" do
    assign(:movie, OpenStruct.new(rating: '9.2'))

    render

    expect(rendered).to have_selector("span.badge", text: '9.2')
  end

  it "displays plot" do
    assign(:movie, OpenStruct.new(plot: 'plot information'))

    render

    expect(rendered).to have_selector("div", text: 'plot information')
  end

  it "displays cover" do
    assign(:movie, OpenStruct.new(cover: 'http://movie.image.com'))

    render

    expect(rendered).to match /http:\/\/movie.image.com/
  end
end