class JournalPreviewUploader < CarrierWave::Uploader::Base
  include CarrierWaveAddons

  RECOMMENDED_DIMENSION = [700, 400].freeze

  storage :file

  def recommended_dimension
    RECOMMENDED_DIMENSION.join('x')
  end

  version :medium do
    process resize_to_fit: [350, 230]
  end

  version :large do
    process resize_to_fit: RECOMMENDED_DIMENSION
  end
end
