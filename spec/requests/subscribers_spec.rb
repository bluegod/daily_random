require "rails_helper"

describe "Unsubscription via email", :type => :feature do
  let!(:subscriber) {create(:subscriber)}
  let(:full_mail) {DailyRandomMailer.random_mail(subscriber.email, 'random quote', subscriber.token)}
  let(:email){ Capybara::Node::Simple.new(full_mail.body.to_s) }

  it 'follows an unsubscribe link from the daily random email' do
    url = subscriber_with_token_url(email: subscriber.email, token: subscriber.token)
    expect(email).to have_link('Unsubscribe', href: url)
    visit url
    expect(page).to have_content('Subscriber removed')
  end
end