class ProvidersController < ApplicationController

  def index
    @user = current_user
    @location = params[:location]
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query OR title ILIKE :query OR specialty ILIKE :query"
      @providers = Provider.where(sql_query, query: "%#{params[:query]}%")
      session[:last_search] = request.url
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

    if params[:location]
      geocoded_location = Geocoder.search(@location)
      @coordinates = geocoded_location.first.coordinates if geocoded_location.present?
      @providers = @providers.sort_by { |provider| provider.distance(@coordinates) } if @coordinates
    end

  end

  def show
    @provider = Provider.find(params[:id])
    regex_remove_city = /,\s.*/
    regex_remove_street = /.*,\s/
    @street = @provider.address.gsub(regex_remove_city, "")
    @city = @provider.address.gsub(regex_remove_street, "")
    @review = Review.new
    @reviews = @provider.reviews
    @markers = [{ lat: @provider.latitude, lng: @provider.longitude }]
    @path_back = session[:last_search] || providers_path
  end
end
