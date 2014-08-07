#encoding:utf-8
class NotificationsController < ApplicationController
 before_filter :authenticate_user!
after_filter :mark_read, :only => :index
 def index
	 @notifications=current_user.notifications.order("created_at DESC")
  end

  def destroy
  	@notification=Notification.find(params.permit(:id)[:id])
	if current_user==@notification.user
		Notification.delete(@notification)
	else
		flash[:notice]="删除失败"
	end
	redirect_to notifications_path
  end
  def mark_read
  	current_user.notifications.update_all(read: true)
  end
end
