# encoding: utf-8

class BookUploader < CarrierWave::Uploader::Base

  storage :file
  def store_dir
    "book_image/"
  end
end
