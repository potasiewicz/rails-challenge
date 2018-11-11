require "rails_helper"

describe UserService do
  subject {UserService.new.top_commenters}
  let(:user1) {create :user}
  let(:user2) {create :user}
  before(:each) do
    create(:comment, user: user1, created_at: DateTime.now - 8.days)
    create(:comment, user: user1, created_at: DateTime.now - 6.day)
  end

  it 'return top commenters from last 7 days' do
    expect(subject).to eq [[user1.name, 1]]
  end

  it 'return top commenters sorted by commenters count desc' do
    create(:comment, user: user2, created_at: DateTime.now - 2.days)
    create(:comment, user: user2, created_at: DateTime.now)

    expect(subject).to eq [[user2.name, 2], [user1.name, 1]]
  end

  it 'return 10 top commenters' do
    11.times {create(:comment)}

    expect(subject.size).to eq 10
  end
end