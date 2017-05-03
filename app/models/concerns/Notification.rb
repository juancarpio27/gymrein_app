class Notification

  def self.send_notification(session)
    if Rails.env.production? and session.android?
      #TODO send android notification
      send_android_notification(session)
    elsif Rails.env.production? and session.ios?
      send_ios_notification(session)
    end
    true
  end

  private

  def send_ios_notification(session)
    certificate = ENV['IOS_CERTIFICATE_PATH']
    passphrase = ENV['APN_CERTIFICATE_PASSPHRASE']
    connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
    connection.open
    notification = Houston::Notification.new(device: session.device_id)
    notification.alert = 'You have a new class!'
    connection.write(notification.message)
    connection.close
  end

  def send_android_notification(session)
    destination = [session.device_id]
    data = {message: 'You have a new class!'}
    GCM.send_notification( destination, data )
  end


end