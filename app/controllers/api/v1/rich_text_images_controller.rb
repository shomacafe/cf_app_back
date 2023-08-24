class Api::V1::RichTextImagesController < ApplicationController

  def upload_rich_text_image
    uploaded_image = params[:image]
    rich_text_image = RichTextImage.new(image: uploaded_image)

    if rich_text_image.save
      render plain: rich_text_image.image.url, status: :ok
    else
      render plain: '画像をアップロードできませんでした', status: :unprocessable_entity
    end
  end
end
