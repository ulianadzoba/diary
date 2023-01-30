module CarrierWaveAddons
  extend ActiveSupport::Concern

  def max_upload_limit
    size_range.last
  end

  def size_range
    0..20.megabytes
  end

  def allowed_extensions
    extension_allowlist.map(&:upcase).join(', ')
  end

  def recommended_dimension
    raise NotImplementedError
  end

  def extension_allowlist
    ['jpg', 'jpeg', 'png']
  end

  included do
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
