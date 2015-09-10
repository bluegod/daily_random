require 'qless/server'

Qless::Server.use Rack::Auth::Basic do |username, password|
  [username, password] == [ENV['ADMIN_USER'], ENV['ADMIN_PASS']]
end