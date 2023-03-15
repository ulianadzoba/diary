class JournalsController < ApplicationController
  include JournalsHelper

  def index
    @pagy, @journals = pagy(collection, items: 9)
  end
    
  def show
    @journal = resource
    @pagy, @posts = pagy(@journal.posts.ordered, items: posts_number)
  end

  private

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
