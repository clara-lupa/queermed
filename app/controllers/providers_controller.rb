class ProvidersController < ApplicationController

  def index

    @user = current_user
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query OR title ILIKE :query OR specialty ILIKE :query OR street ILIKE :query OR city ILIKE :query"
      @providers = Provider.where(sql_query, query: "%#{params[:query]}%")
    else
      @providers = Provider.all
    end
  end

  def show
    @provider = Provider.find(params[:id])
  end
end
