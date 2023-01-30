class JournalsController < ApplicationController
  def index
    @journals = collection
  end
    
  def show
    @journal = resource
  end

  private

  def collection
    Journal.shared.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
