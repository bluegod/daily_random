class SubscribersController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASS'], except: [:new, :create]

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
    if !@subscriber.destroy
      flash[:error] = "Error: #{@subscriber.errors.full_messages.join(' and ')}"
    else
      flash[:success]  = 'Subscriber removed.'
    end
    redirect_to subscribers_path
  end

  private
  def subscriber_params
    @_subscriber_params ||=  params.permit(subscriber: [:email])
  end
end
