require "rails_helper"

describe "comments process", type: :feature do
  before :each do
    @user = create(:user)
    @movie = create(:movie)
    stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{@movie.title}")
        .to_return(body: '{"data":{"id":"6","type":"movie","attributes":{"title":"Godfather","plot":"coming soon","rating":9.2,"poster":"/godfather.jpg"}}}')

    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end

    expect(page).to have_content 'Pairguru App'
  end

  it "user can comment movie" do
    visit "/movies/#{@movie.id}"

    expect(page).to have_content @movie.title

    fill_in 'comment', with: 'this is my first comment'
    click_button 'Create Comment'

    expect(page).to have_content 'Comment has been created.'
    expect(page).to have_content 'this is my first comment'
  end

  it "user cannot comment the same movie twice" do
    create(:comment, user: @user, movie: @movie)

    visit "/movies/#{@movie.id}"
    expect(page).to have_content @movie.title

    fill_in 'comment', with: 'this is my first comment'
    click_button 'Create Comment'

    expect(page).to have_content 'User could add only one comment to the movie.'
  end

  it "user can remove added comment" do
    create(:comment, user: @user, movie: @movie)

    visit "/movies/#{@movie.id}"
    expect(page).to have_content @movie.title

    click_link 'Delete'

    expect(page).to have_content 'Your comment has been removed.'
  end
end