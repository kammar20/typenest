class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    1.byte..5.megabytes
  end
end
