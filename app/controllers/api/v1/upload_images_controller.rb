class Api::V1::UploadImagesController < ApplicationController
  def create
    image_uploader = ImageUploader.new
    image_uploader.store!(params[:image])

    render json: { url: image_uploader.url }
  rescue => e
    render json: { error: '画像のアップロードに失敗しました' }, status: :unprocessable_entity
  end
end
