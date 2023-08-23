class Api::V1::UploadsController < ApplicationController

  def upload_image
    uploaded_image = params[:image]
    uploader = ImageUploader.new

    if uploader.store!(uploaded_image)
      render plain: uploader.url, status: :ok
    else
      render plain: '画像をアップロードできませんでした', status: :unprocessable_entity
    end
  end
end
