class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWaveAddons

  RECOMMENDED_DIMENSION = [50, 50].freeze

  storage :file

  def recommended_dimension
    RECOMMENDED_DIMENSION.join('x')
  end

  version :thumb do
    process resize_to_fit: RECOMMENDED_DIMENSION
  end
end
