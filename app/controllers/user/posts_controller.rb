class User::PostsController < User::AccountController
  def show
    @journal = journal_resource
    @post = resource
  end

  def new
    @journal = journal_resource
    @post = collection.build
  end

  def create
    @journal = journal_resource
    @post = collection.build(post_params)

    if @post.save
      redirect_to [:user, @journal, @post], notice: 'Post has been created'
    else
      render :new
    end
  end

  def edit
    @journal = journal_resource
    @post = resource
  end

  def update
    @journal = journal_resource
    @post = resource

    if @post.update(post_params)
      flash.now[:notice] = 'Post has been updated'

      render formats: :turbo_stream
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal = journal_resource
    @post = resource

    @post.destroy
    redirect_to [:user, @journal], notice: 'Journal has been removed.'
  end

  private

  def journal_resource
    journal_ids = current_user.own_journals.pluck(:id) + current_user.journals.pluck(:id)
    Journal.where(id: journal_ids).find(params[:journal_id])
  end

  def collection
    journal_resource.posts
  end

  def resource
    collection.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :journal_id,
      images_attributes: [:id, :file, :description, :_destroy])
  end
end
