class AddTokenToSubscriber < ActiveRecord::Migration
  class Subscriber < ActiveRecord::Base
  end
  def change
    add_column :subscribers, :token, :string
    Subscriber.update_all(token: SecureRandom.urlsafe_base64)
  end
end
