class User::JournalsController < User::AccountController
  def index
    @journals = collection
  end

  def show
    @journal = resource
  end

  def new
    @journal = collection.build
  end

  def create
    @journal = collection.build(journal_params)

    if @journal.save
      flash.now[:notice] = 'Diary has been created'

      render formats: :turbo_stream
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @journal = resource
  end

  def update
    @journal = resource

    if @journal.update(journal_params)
      flash.now[:notice] = 'Diary has been updated'

      render formats: :turbo_stream
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal = resource

    @journal.destroy
    redirect_to [:user, :journals], notice: 'Diary has been removed.'
  end

  def new_author
    @journal = resource
  end

  def assign_author
    @journal = resource
    email = params.dig(:journal, :email)
    user = User.find_by(email: email)

    if user
      if user.journals.exists?(@journal.id)
        flash.now[:alert] = "User with email #{email} is already assigned"
      else
        user.journals << @journal
        Notifier.new(user: user, journal: @journal, type: Notification::INVITE_AUTHOR_NOTIFICATION).create_notification
        
        flash.now[:notice] = 'User is successfully assigned'
      end
    else
      flash.now[:alert] = 'Please check that email is valid and user is already registered'
      render turbo_stream: turbo_stream.append('modal', partial: 'user/journals/assign_author_modal', locals: {journal: @journal}) +
                           turbo_stream.append('flash', partial: 'shared/flash')
    end
  end

  private 

  def collection
    journal_ids = current_user.own_journals.pluck(:id) + current_user.journals.pluck(:id)
    Journal.where(id: journal_ids)
  end

  def resource
    collection.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:name, :description, :preview, :private)
  end
end
