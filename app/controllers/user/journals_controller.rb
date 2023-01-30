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

  private 

  def collection
    current_user.own_journals
  end

  def resource
    collection.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:name, :description, :preview, :private)
  end
end
