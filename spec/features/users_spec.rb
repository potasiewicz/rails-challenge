require "rails_helper"

describe "top commenters", type: :feature do
  before(:each) do
    @comment = create(:comment)
  end
  it 'anyone can see top commenters page' do
    visit 'users/commenters'

    expect(page).to have_content 'The most active commenters in current week'
    expect(page).to have_content @comment.user.name
  end
end