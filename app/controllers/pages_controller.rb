class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def shortlist
    @user = current_user #check shortlist for current user
    @providers = Shortlist.all.map { |shortlist|
      shortlist.provider
    }
  end
end

