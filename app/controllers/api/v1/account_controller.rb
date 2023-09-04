class Api::V1::AccountController < ApplicationController
  before_action :authenticate_api_v1_user!

  def update
    @user = current_api_v1_user

    # メールアドレスの更新がある場合、現在のパスワードの検証を行う
    if params[:email].present?
      unless @user.valid_password?(params[:current_password])
        render json: { errors: ['現在のパスワードが正しくありません'] }, status: :unprocessable_entity
        return
      end
    end

    if @user.update(account_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.permit(:email, :password, :password_confirmation)
  end
end
