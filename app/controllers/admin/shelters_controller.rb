class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_shelters_reverse_alphabetical
    @pending_app_shelters = Shelter.shelters_with_pending_apps
  end


end