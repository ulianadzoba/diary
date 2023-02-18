class Notifier
  def initialize(user:, journal:, type: Notification::INVITE_AUTHOR_NOTIFICATION)
    @user = user
    @journal = journal
    @type = type
  end

  def create_notification
    @user.notifications.find_or_create_by(type: @type, journal: @journal)
  end
end
