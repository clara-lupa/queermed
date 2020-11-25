class ProvidersController < ApplicationController

  def index

    @user = current_user
    @location = params[:location]
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query OR title ILIKE :query OR specialty ILIKE :query"
      @providers = Provider.where(sql_query, query: "%#{params[:query]}%")
    else
      @providers = Provider.all
    end

    @markers = @providers.geocoded.map do |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { provider: provider })
      }
    end

    @providers = @providers.sort_by{ |provider| provider.distance(@location) }
  end

  def show
    @provider = Provider.find(params[:id])
  end
end
