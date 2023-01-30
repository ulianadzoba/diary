class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWaveAddons

  RECOMMENDED_DIMENSION = [750, 750].freeze

  storage :file

  def recommended_dimension
    RECOMMENDED_DIMENSION.join('x')
  end

  version :thumb do
    process resize_to_fit: [60, 60]
  end

  version :medium do
    process resize_to_fit: [300, 300]
  end

  version :large do
    process resize_to_fit: RECOMMENDED_DIMENSION
  end
end
