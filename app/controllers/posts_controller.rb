class PostsController < ApplicationController
  before_action :check_if_post_published, only: :show

  def show
    @post = resource
  end

  private

  def check_if_post_published
    @post = resource

    redirect_to root_path, notice: "You do not have access to visit this page" unless @post.published?
  end

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
