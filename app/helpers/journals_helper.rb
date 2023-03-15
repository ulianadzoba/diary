module JournalsHelper
  def posts_number
    (params[:page].nil? || params[:page] == 1) ? 8 : 9
  end
end
