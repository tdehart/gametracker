# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => ENV['S3_REGION'],
    }

    config.fog_directory  = 'gametracker' 
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def default_url
      "/assets/" + [version_name, "placeholder.png"].compact.join('_')
  end

  version :large_thumb do
    process :resize_to_fit => [64, 64]
  end

  version :med_thumb, :from_version => :large_thumb do
    process :resize_to_fit => [32, 32]
  end

  version :small_thumb, :from_version => :med_thumb do
    process :resize_to_fit => [16, 16]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
