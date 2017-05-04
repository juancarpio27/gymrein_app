class Notification

  def self.send_notification(session,class_date)
    if Rails.env.production? and session.android?
      #TODO send android notification
      self.send_android_notification(session,class_date)
    elsif Rails.env.production? and session.ios?
      self.send_ios_notification(session,class_date)
    end
    true
  end

  private

  def self.send_ios_notification(session,class_date)
    certificate = ENV['IOS_CERTIFICATE_PATH']
    passphrase = ENV['APN_CERTIFICATE_PASSPHRASE']
    connection = Houston::Connection.new(Houston::APPLE_DEVELOPMENT_GATEWAY_URI, certificate, passphrase)
    connection.open
    notification = Houston::Notification.new(device: session.device_id)
    notification.alert = 'Se desocupo un puesto en la clase ' + class_date.event.name + '. Tu clase empieza a las ' + class_date.datestrftime("%H:%M %m/%d/%y")
    connection.write(notification.message)
    connection.close
  end

  def self.send_android_notification(session,class_date)
    destination = [session.device_id]
    data = {message: 'You have a new class!'}
    GCM.send_notification( destination, data )
  end


end