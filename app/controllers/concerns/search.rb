module Search
  extend ActiveSupport::Concern

  def search_field
    params[:query].present? ? params[:query] : '*'
  end

  def category_id
    params[:category_id].present? ? params[:category_id].to_i : nil
  end
end