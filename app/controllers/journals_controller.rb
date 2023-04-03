class JournalsController < ApplicationController
  include JournalsHelper

  def index
    @pagy, @journals = pagy(collection, items: 9)
  end
    
  def show
    @journal = resource
    @pagy, @posts = pagy(@journal.posts.ordered, items: posts_number)
  end

  def search
    results = Journal.pagy_search(params[:query], **search_params)
    @pagy, @journals = pagy_searchkick(results, items: 9)
  end

  def suggestions
    @results = Journal.search(params[:query], **search_params)
  end

  private

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end

  def search_params
    { 
      fields: %i[name description], 
      operator: 'or',
      match: :text_middle
    }
  end
end
