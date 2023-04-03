class NotificationsController < ApplicationController
  def index
    @notifications = Notification.get_notifications(params[:user_id])
    update_unseen_notif(@notifications)
  end

  private

  def update_unseen_notif(notifs)
    notifs.each do |notif|
      next unless notif.unseen?

      notif.seen!
    end
  end
end
