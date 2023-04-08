class NotificationsController < ApplicationController
  def index
    @notifications = Notification.get_notifications(current_user)
    @notif_to_update = Notification.udpate_notifications(current_user)
    update_unseen_notif(@notif_to_update) unless @notif_to_update.unseen.empty?
  end

  def update_notif
    @notif = Notification.find(params[:id])
    @notif.reviewed! unless @notif.reviewed?

    redirect_to get_path(@notif)
  end

  private

  def update_unseen_notif(notifs)
    notifs.each do |notif|
      next unless notif.unseen?

      notif.seen!
    end
  end

  def get_path(notif)
    case notif.notifiable_type
    when "Friend"
      user_path(notif.sender)
    else
      post_path(notif.notifiable.post)
    end
  end
end
