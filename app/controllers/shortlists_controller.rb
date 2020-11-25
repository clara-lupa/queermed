class ShortlistsController < ApplicationController
  def create
    @shortlist = Shortlist.new
    @shortlist.user = current_user
    @shortlist.provider = Provider.find(params[:provider_id])
    @shortlist.save
  end

  def destroy
    @shortlist = Shortlist.find(params[:id])
    @shortlist.destroy
  end
end
