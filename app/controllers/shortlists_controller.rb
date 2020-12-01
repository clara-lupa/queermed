class ShortlistsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :destroy

  def create
    @shortlist = Shortlist.new
    @shortlist.user = current_user
    @shortlist.provider = Provider.find(params[:provider_id])

    @shortlist.save
    redirect_back(fallback_location: providers_path)
  end

  def favorites
    favorite = Shortlist.find_by_id(params[:id])
    provider = Provider.find(params[:provider_id])
    if favorite.present?
      favorite.destroy
      render json: { message: "favorite deleted"}
    else
      Shortlist.create!(provider: provider, user: current_user)
      render json: { message: "favorite created"}
    end
  end
end
