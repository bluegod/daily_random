require 'rails_helper'

describe SubscribersController, type: :controller do
  let(:test_email) {'test@dailyrandom.test'}
  let(:invalid_email) {'@invalid'}
  let!(:subscriber) {create(:subscriber)}

  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV['ADMIN_USER'], ENV['ADMIN_PASS'])
  end

  it "should get the subscription index page" do
    get 'index'
    expect(response).to be_success
  end

  it "should get the subscription new page" do
    get 'new'
    expect(response).to be_success
  end

  it "should create a new subscription" do
    expect{
      post :create, subscriber: {email: test_email}
    }.to change(Subscriber, :count).by(1)
  end

  it "should delete a subscription" do
    expect{
      delete :destroy, :id => subscriber.id
    }.to change(Subscriber, :count).by(-1)
  end

  it "should not create a new subscription entering an empty email" do
    expect{
      post :create, subscriber: {email: ''}
    }.not_to change(Subscriber, :count)
  end

  it "should not create a new subscription entering an invalid email" do
    expect{
      post :create, subscriber: {email: invalid_email}
    }.not_to change(Subscriber, :count)
  end
end