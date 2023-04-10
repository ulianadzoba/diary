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
    results = 
      if category_id
        additional_params = { where: { category_id: category_id } }
        Journal.pagy_search(search_field, **search_category_params, **additional_params)
      else
        Journal.pagy_search(search_field, **search_input_params)
      end

    @pagy, @journals = pagy_searchkick(results, items: 9)
  end

  def suggestions
    @results = 
      if category_id
        additional_params = { where: { category_id: category_id } }
        Journal.search(search_field, **search_category_params, **additional_params)
      else
        Journal.search(search_field, **search_input_params)
      end
  end

  private

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end

  def search_field
    params[:query].present? ? params[:query] : '*'
  end

  def category_id
    params[:category_id].present? ? params[:category_id].to_i : nil
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
      where: { private: false },
      fields: %i[name description category_id], 
      operator: 'or',
      match: :text_middle
    }
  end
end
