class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @user = current_user
    @location = params[:location]
    session[:last_search] = request.url
    session[:come_from_search] = true
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
    @reviews = @provider.reviews.order({ created_at: :desc })
    @markers = [{ lat: @provider.latitude, lng: @provider.longitude }]
    @path_back = session[:last_search] || providers_path
  end

  def new
    session[:come_from_search] = false
    @provider = Provider.new
    @providers = Provider.all
    @specialty_array = []
    @providers.each { |provider| @specialty_array << provider.specialty }
    @specialty_array = @specialty_array.uniq
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      redirect_to provider_path(@provider)
    else
      render :new
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:title, :first_name, :last_name, :specialty, :homepage, :email, :phone_number, :address)
  end
end

