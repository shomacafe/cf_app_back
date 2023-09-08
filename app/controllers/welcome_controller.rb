class WelcomeController < ApplicationController
  def index
    render json: { message: 'welcome rails API' }
  end
end
