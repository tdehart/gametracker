# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAIV5QYTJHRL6HW7MQ',                        # required
      :aws_secret_access_key  => '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',                        # required
      :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
    }

    config.fog_directory  = 'gametracker' 
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
      "/assets/" + [version_name, "placeholder.png"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  version :large_thumb do
    process :resize_to_fit => [64, 64]
  end

  version :med_thumb, :from_version => :large_thumb do
    process :resize_to_fit => [32, 32]
  end

  version :small_thumb, :from_version => :med_thumb do
    process :resize_to_fit => [16, 16]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
