require 'houston'

# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`. APN = Houston::Client.development
if Rails.env.development?
  APN = Houston::Client.development
  APN.certificate = File.read(Rails.root.join('config','MyGymCKUnEn.pem'))
elsif Rails.env.production?
  APN = Houston::Client.production
  APN.certificate = ENV['IOS_CERTIFICATE_PATH']
end

if Rails.env.production?
  APNS.host = 'gateway.push.apple.com'
else
  APNS.host = 'gateway.sandbox.push.apple.com'
end

# gateway.sandbox.push.apple.com is default and only for development
# gateway.push.apple.com is only for production

APNS.port = 2195
# this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

APNS.pem = ENV['IOS_CERTIFICATE_PATH']