class SubscribersController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASS'], only: :index
  before_action :auth_or_token, only: :destroy

  def new
    @subscriber = Subscriber.new
  end

  def index
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.new(subscriber_params[:subscriber])
    if !@subscriber.save
      flash[:error] = "Error: #{@subscriber.errors.full_messages.join(' and ')}"
    else
      flash[:success]  = 'Success! You will get your daily random quote soon.'
    end
    redirect_to root_path
  end

  def destroy
    @subscriber = Subscriber.find_by_id(params.permit([:id])[:id])
    if @subscriber.nil?
      flash[:error] = "Error: Subscriber not found."
    elsif !@subscriber.destroy
      flash[:error] = "Error: #{@subscriber.errors.full_messages.join(' and ')}"
    else
      flash[:success]  = 'Subscriber removed.'
    end
    redirect_to root_path
  end

  private
  def subscriber_params
    @_subscriber_params ||=  params.permit(subscriber: [:email])
  end

  def auth_or_token
    #Tries to auth via token, otherwise defaults to basic auth.
    if auth_params[:token] && auth_params[:email]
      subscriber = Subscriber.find_by_token_and_email(auth_params[:token], auth_params[:email])
      if subscriber
        params[:id] = subscriber.id
        return
      end
    end
    authenticate_or_request_with_http_basic("Application") do |username, password|
      [username, password] == [ENV['ADMIN_USER'], ENV['ADMIN_PASS']]
    end
  end

  def auth_params
    params.permit(:token, :email)
  end
end
