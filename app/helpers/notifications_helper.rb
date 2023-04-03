module NotificationsHelper
  def notif_message(notif)
    case notif.notifiable.status
    when "accepted"
      "#{notif.sender.name} accepted your friend request"
    else
      "#{notif.sender.name} sent you a friend request"
    end
  end

  def get_path(notif)
    case notif.notifiable_type
    when "Friend"
      user_path(notif.sender)
    end
  end

  def get_notif_date(notif)
    notif.created_at.strftime("%b %d, %Y")
  end

  def get_notif_time(notif)
    notif.created_at.strftime("%I:%M %P")
  end
end
