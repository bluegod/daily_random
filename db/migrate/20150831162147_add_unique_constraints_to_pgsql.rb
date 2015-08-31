class AddUniqueConstraintsToPgsql < ActiveRecord::Migration
  def change
    add_index :subscribers, :email, :unique => true
    add_index :subscribers, :token, :unique => true
  end
end
