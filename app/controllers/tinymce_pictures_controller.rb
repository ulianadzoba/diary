class TinymcePicturesController < ApplicationController
  skip_forgery_protection

  def create
    picture = TinymcePicture.new(picture: tinymce_picture_params[:file])

    if picture.save
      render json: { location: picture.picture.url, content_type: 'text/html' }
    else
      render json: {
        error: picture.errors.full_messages.to_sentence,
        status: 400
      }, status: :bad_request
    end
  end

  private

  def tinymce_picture_params
    params.permit(:file)
  end
end
