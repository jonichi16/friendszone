module NotificationsHelper
  def notif_message(notif)
    notif_type = notif.notifiable_type
    notifiable = notif.notifiable

    if notif_type == "Friend" && notifiable.status == "accepted"
      "#{notif.sender.name} accepted your friend request"
    elsif notif_type == "Comment"
      "#{notif.sender.name} commented on your post"
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
