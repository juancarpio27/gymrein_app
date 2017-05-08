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

GCM.host = 'https://android.googleapis.com/gcm/send'
GCM.format = :json
#TODO include android API KEY
GCM.key = 'AIzaSyAlCB41qR9PmUs-3N8OMdJt6npg9LHgVW4'