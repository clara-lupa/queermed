class ShortlistsController < ApplicationController
  def create
    @shortlist = Shortlist.new
    @shortlist.user = current_user
    @shortlist.provider = Provider.find(params[:provider_id])
    @shortlist.save
    redirect_back(fallback_location: providers_path)
  end

  def destroy
    @shortlist = Shortlist.find(params[:id])
    @shortlist.destroy
    redirect_to shortlists_index_path
  end
end
