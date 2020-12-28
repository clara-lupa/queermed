class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def shortlist
    @user = current_user # check shortlist for current user
    # @providers = @user.shortlists.map { |shortlist|
    #   shortlist.provider
    # }
    @providers = @user.providers
    @shortlists = @user.shortlists
    @markers = @providers.geocoded.map { |provider|
      {
        lat: provider.latitude,
        lng: provider.longitude
        # infoWindow: render_to_string(partial: "info_window", locals: { provider: provider })
      }
    }
  end
end
