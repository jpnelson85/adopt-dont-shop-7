class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_shelters_reverse_alphabetical
  end
end