class Api::V1::ReturnsController < ApplicationController
  before_action :find_return, only: [:update, :destroy]

  def index
    @returns = Return.where(project_id: params[:project_id])
    if @returns.any?
      render json: @returns
    else
      render json: { error: "Not Found" }, status: :not_found
    end
  end

  def show
    @return = Return.where(project_id: params[:project_id], id: params[:id]).first
    if @return
      render json: @return
    else
      render json: { error: "Not Found" }, status: :not_found
    end
  end

  def create
    @return = Return.new(return_params)

    if @return.save
      render json: @return, status: :created
    else
      render json: @return.errors, status: :unprocessable_entity
    end
  end

  def update
    if @return.update(return_params)
      render json: @return, status: :ok
    else
      render json: @return.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @return.destroy
    head :no_content
  end

  private

  def find_return
    @return = Return.find(params[:id])
  end

  def return_params
    params.require(:return).map do |param|
      param.permit(:id, :project_id, :name, :price, :return_image, :description, :stock_count, :supporter_count, :_destroy)
    end
  end
end
