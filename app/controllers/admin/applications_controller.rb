class Admin::ApplicationsController < ApplicationController 
  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.pets
  end

  def update
    @applicant = Applicant.find(params[:id])

    @applicant.update(app_params)


    redirect_to "/admin/applications/#{@applicant.id}"
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :qualification, :application_status)
  end
end