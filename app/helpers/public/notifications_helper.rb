module Public::NotificationsHelper
  def notification_form(notification)
    @visiter = notification.active
    @comment = nil
    # your_post = link_to 'あなたの投稿', post_path(notification), style: "font-weight: bold; color:rgb(063,163,203);"
    @active_comment = notification.post_comment_id

    case notification.action
    when "follow" then
      tag.a(notification.active.name, href: listener_path(@visiter), class: "notification_text link p-0") + "があなたをフォローしました。"
    when "like" then
      tag.a(notification.active.name, href: listener_path(@visiter), class: "notification_text link p-0") + "が" + tag.a('あなた投稿を', href: post_path(notification.post_id), class: "notification_text link p-0") + "いいねしました。"
    when "comment" then
      @comment = PostComment.find_by(id: @active_comment)&.comment
      tag.a(@visiter.name, href: listener_path(@visiter), class: "notification_text link p-0") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), class: "notification_text link p-0") + "にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_listener.passive_notifications.where(checked: false)
  end
end
