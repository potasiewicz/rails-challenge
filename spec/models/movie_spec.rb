require "rails_helper"

describe Movie do
  it 'title should be validate by TitleBracketsValidator' do
    expect(Movie.validators).to include a_kind_of(TitleBracketsValidator)
  end
end