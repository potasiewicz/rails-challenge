require "rails_helper"

describe "movies/index.html.haml" do
  before(:each) do
    allow(controller).to receive(:user_signed_in?).and_return(true)
  end

  it "display rating" do
    assign(:movies, [OpenStruct.new(rating: '9.2', genre: OpenStruct.new(name: 'someone'))])

    render

    expect(rendered).to have_selector("span.badge", text: '9.2')
  end

  it "display plot" do
    assign(:movies, [OpenStruct.new(plot: 'plot information', genre: OpenStruct.new(name: 'someone'))])

    render

    expect(rendered).to have_selector("p", text: 'plot information')
  end
end