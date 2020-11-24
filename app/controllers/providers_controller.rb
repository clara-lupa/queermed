class ProvidersController < ApplicationController
  def show
    @provider = Provider.find(params[:id])
  end
end
