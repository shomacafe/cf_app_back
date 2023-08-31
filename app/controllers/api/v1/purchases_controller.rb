class Api::V1::PurchasesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    @purchases = current_api_v1_user.purchases.includes(:return, :project)
    render json: @purchases, include: [:return, :project]
  end

  def create
    return_id = purchase_params[:return_id]
    quantity = purchase_params[:quantity]

    return_item = Return.find(return_id)
    return_item.update(stock_count: return_item.stock_count - quantity, supporter_count: return_item.supporter_count + 1)

    price = return_item.price
    amount = price * quantity

    user_id = current_api_v1_user.id
    project_id = return_item.project_id

    @purchase = Purchase.new(
      user_id: user_id,
      project_id: project_id,
      return_id: return_id,
      quantity: quantity,
      amount: amount
    )

    if @purchase.save
      render json: @purchase, status: :created
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:return_id, :project_id, :quantity, :amount)
  end
end
