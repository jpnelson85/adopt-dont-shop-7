require 'rails_helper'

RSpec.describe "admin shelters index page" do
  
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  end

  it 'when visited, see all shelters in system in reverse alphabeltical order by name' do
  visit "/admin/shelters"

  expect(page).to have_content(@shelter_1.name)
  expect(page).to have_content(@shelter_2.name)
  expect(page).to have_content(@shelter_3.name)
  expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
  expect(@shelter_2.name).to appear_before(@shelter_3.name)
  end

  it 'be able to see section for "Shelters with Pending Applications"' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
  end

  it 'see name of every shelter with pending application in "Shelters with Pending Applications"' do
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "Pending")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)

    visit "/admin/shelters"

    within("#shelters") do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
    end
  end
end