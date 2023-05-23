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
end