class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy, :index_by_user]
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all
    render json: @projects, include: :returns
  end

  def index_by_user
    @projects = current_api_v1_user.projects
    render json: @projects, include: :returns
  end

  def show
    render json: @project, include: :returns
  end

  def create
    @project = current_api_v1_user.projects.build(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private

  def project_params
    params.permit(
      :title, :goal_amount, :start_date, :end_date, :description, :is_published,
      catch_copies: [], project_images: [],
      returns_attributes: [:id, :name, :price, :return_image, :description, :stock_count, :_destroy]
    )
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
