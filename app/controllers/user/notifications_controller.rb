class User::NotificationsController < User::AccountController
  def index
    @pagy, @notifications = pagy(collection, items: 10)
  end

  def show
    @notification = resource
    @notification.update_column(:seen, true) unless @notification.seen?

    redirect_to params[:redirect_url]
  end

  def mark_all_as_read
    @notifications = collection
    if @notifications.unseen.update_all(seen: true)
      render formats: :turbo_stream
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def collection
    current_user.notifications.ordered.includes(:journal)
  end

  def resource
    collection.find(params[:id])
  end
end