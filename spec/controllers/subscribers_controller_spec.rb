describe SubscriberController do
  let(:test_email) {'test@dailyrandom.test'}
  let(:invalid_email) {'@invalid'}
  it "should get the subscription index page" do
    get 'index'
    expect(response).to be_success
  end

  it "should create a new subscription" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect{
      post :create, subscriber: {email: test_email}
    }.to change(Subscriber,:count).by(1)
  end

  it "should not create a new subscription entering an empty email" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect{
      post :create, subscriber: {email: ''}
    }.not_to change(Subscriber, :count).by(1)
  end

  it "should not create a new subscription entering an invalid email" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect{
      post :create, subscriber: {email: test_email}
    }.not_to change(Subscriber, :count).by(1)
  end
end