class User::JournalsController < User::AccountController
  include JournalsHelper
  include Search
  
  def index
    @pagy, @journals = pagy(collection, items: 9)
  end

  def show
    @journal = resource
    @pagy, @posts = pagy(@journal.posts.ordered, items: posts_number)
  end

  def search
    results = 
      if category_id
        additional_params = { where: { category_id: category_id } }
        Journal.pagy_search(search_field, **search_category_params)
      else
        Journal.pagy_search(search_field, **search_input_params)
      end

    @pagy, @journals = pagy_searchkick(results, items: 9)
  end

  def suggestions
    @results = 
      if category_id
        Journal.search(search_field, **search_category_params)
      else
        Journal.search(search_field, **search_input_params)
      end
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
    Journal.where(id: related_journals_ids).includes(:posts)
  end

  def resource
    collection.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:name, :description, :preview, :private, :category_id)
  end

  def related_journals_ids
    current_user.own_journals.pluck(:id) + current_user.journals.pluck(:id)
  end
  
  def search_input_params
    { 
      where: { id: related_journals_ids, private: false },
      fields: %i[name description], 
      operator: 'or',
      match: :text_middle
    }
  end

  def search_category_params
    { 
      where: { id: related_journals_ids, category_id: category_id, private: false },
      fields: %i[name description category_id], 
      operator: 'or',
      match: :text_middle
    }
  end
end
