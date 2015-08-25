require 'rails_helper'

describe SubscribersController, type: :controller do
    let(:test_email) {'test@dailyrandom.test'}
    let(:invalid_email) {'@invalid'}

    it "should get the subscription index page" do
      get 'index'
      expect(response).to be_success
    end

    it "should create a new subscription" do
      expect{
        post :create, subscriber: {email: test_email}
      }.to change(Subscriber, :count).by(1)
    end

    it "should not create a new subscription entering an empty email" do
      expect{
        post :create, subscriber: {email: ''}
      }.not_to change(Subscriber, :count).by(1)
    end

    it "should not create a new subscription entering an invalid email" do
      expect{
        post :create, subscriber: {email: test_email}
      }.not_to change(Subscriber, :count).by(1)
    end

end
