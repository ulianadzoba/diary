class PostsController < ApplicationController
  def show
    @post = resource
  end

  private

  def journal_resource
    Journal.find(params[:journal_id])
  end
  
  def collection
    journal_resource.posts
  end

  def resource
    collection.find(params[:id])
  end
end
