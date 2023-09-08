class Api::V1::ProfileController < ApplicationController
  before_action :authenticate_api_v1_user!

  def update
    @user = current_api_v1_user

    if @user.update(profile_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :user_image, :profile)
  end
end
