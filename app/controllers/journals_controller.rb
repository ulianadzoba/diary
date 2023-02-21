class JournalsController < ApplicationController
  def index
    @pagy, @journals = pagy(collection, items: 9)
  end
    
  def show
    @journal = resource
    @pagy, @posts = pagy(@journal.posts.ordered, items: 9)
  end

  private

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
