class NotificationsController < ApplicationController
  def index
    @notifications = Notification.get_notifications(params[:user_id])
  end
end
