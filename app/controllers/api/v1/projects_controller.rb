class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy, :index_by_user]
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all.includes(:purchases)

    if params[:search].present?
      @projects = @projects.where('title LIKE ?', "%#{params[:search]}%")
    end

    @projects = @projects.where(is_published: true)

    project_with_info = @projects.map do |project|
      total_amount = project.purchases.sum(:amount)
      support_count = project.purchases.count

      {
        project: project,
        total_amount: total_amount,
        support_count: support_count
      }
    end
    render json: project_with_info, include: :returns
  end

  def index_by_user
    @projects = current_api_v1_user.projects

    project_with_info = @projects.map do |project|
      total_amount = project.purchases.sum(:amount)
      support_count = project.purchases.count

      {
        project: project,
        total_amount: total_amount,
        support_count: support_count
      }
    end
    render json: project_with_info, include: :returns
  end

  def show
    total_amount = @project.purchases.sum(:amount)
    support_count = @project.purchases.count

    render json:{
      project: @project,
      total_amount: total_amount,
      support_count: support_count,
      user: @project.user.as_json(only: [:name]) #TODO: プロフィールやアイコンも追加
    }, include: :returns
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
    @project = current_api_v1_user.projects.find(params[:id])

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

  def recommended
    current_project_id = params[:current_project_id]
    @projects = Project.all.includes(:purchases)

    common_projects = @projects.where('start_date <= ?', Time.current)
                               .where('end_date > ?', Time.current)
                               .where(is_published: true)
                               .where.not(id: current_project_id)

    if params[:criteria].present?
      case params[:criteria]
      when 'newest'
        @projects = common_projects.order('start_date DESC').limit(4)
      when 'endingSoon'
        @projects = common_projects.order('end_date ASC').limit(4)
      when 'totalAmount'
        @projects = common_projects.left_joins(:purchases)
                                   .group(:id)
                                   .order('SUM(purchases.amount) DESC')
                                   .limit(4)
      when 'supportCount'
        @projects = common_projects.left_joins(:purchases)
                                   .group(:id)
                                   .order('COUNT(purchases.id) DESC')
                                   .limit(4)
      when 'newestSlideshow'
        @projects = common_projects.order('start_date DESC').limit(6)
      end
    end

    project_with_info = @projects.map do |project|
      total_amount = project.purchases.sum(:amount)
      support_count = project.purchases.count

      {
        project: project,
        total_amount: total_amount,
        support_count: support_count
      }
    end

    render json: project_with_info, include: :returns
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
