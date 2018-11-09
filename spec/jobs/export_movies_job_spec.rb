require 'rails_helper'

RSpec.describe ExportMoviesJob, type: :job do
  include ActiveJob::TestHelper
  it 'should send email with movies details' do
    user = create :user
    perform_enqueued_jobs do
      ExportMoviesJob.perform_later(user)
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq user.email
    expect(mail.subject).to eq 'Your export is ready'
  end
end
