class JournalsController < ApplicationController
  include JournalsHelper
  include Search

  before_action :check_if_journal_public, only: :show

  def index
    @pagy, @journals = pagy(collection, items: 9)
  end
    
  def show
    @journal = resource
    @pagy, @posts = pagy(@journal.posts.published.ordered, items: 9)
  end

  def search
    results = 
      if category_id
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

  private

  def check_if_journal_public
    @journal = resource

    redirect_to root_path, notice: "You do not have access to visit this page" if @journal.private?
  end

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end
  
  def search_input_params
    { 
      where: { private: false },
      fields: %i[name description], 
      operator: 'or',
      match: :text_middle
    }
  end

  def search_category_params
    { 
      where: { private: false, category_id: category_id },
      fields: %i[name description category_id], 
      operator: 'or',
      match: :text_middle
    }
  end
end
