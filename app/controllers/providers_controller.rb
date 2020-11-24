class ProvidersController < ApplicationController
  def index
    @user = current_user
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query OR title ILIKE :query OR speciality ILIKE :query OR address ILIKE :query"
      @providers = Provider.where(sql_query, query: "%#{params[:query]}%")
    else
      @providers = Provider.all
    end
  end
end
