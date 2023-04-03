module NotificationsHelper
  def notif_message(notif)
    case notif.notifiable.status
    when "accepted"
      "#{notif.sender.name} accepted your friend request"
    else
      "#{notif.sender.name} sent you a friend request"
    end
  end

  def get_notif_date(notif)
    notif.created_at.strftime("%b %d, %Y")
  end

  def get_notif_time(notif)
    notif.created_at.strftime("%I:%M %P")
  end

  def seen_notifs
    current_user.notifications.unseen.empty?
  end
end
