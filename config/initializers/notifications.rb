require 'houston'

# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`. APN = Houston::Client.development
if Rails.env.development?
  APN = Houston::Client.development
  APN.certificate = "#{RAILS_ROOT}/config/MyGymCK.pem"
elsif Rails.env.production?
  APN = Houston::Client.production
  APN.certificate = "#{RAILS_ROOT}/config/MyGymCK.pem"
end