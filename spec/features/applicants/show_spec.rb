require "rails_helper"

RSpec.describe "the application show page" do
  it "shows an application show page with form attributes" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "In Progress")
    applicant_2 = Applicant.create!(name: "Bob", street_address: "568 Main Street", city: "Springfield", state: "GA", zip_code: "56898", qualification: "because", application_status: "In Progress")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)

    visit "applicants/#{applicant_1.id}"

    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content("Full Address: #{applicant_1.street_address} #{applicant_1.city} #{applicant_1.state} #{applicant_1.zip_code}")
    expect(page).to have_content(applicant_1.qualification)
    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content(applicant_1.application_status)
    expect(page).to have_link("Scooby")
    expect(page).to_not have_content(applicant_2.name)
    expect(page).to_not have_content("Full Address: #{applicant_2.street_address} #{applicant_2.city} #{applicant_2.state} #{applicant_2.zip_code}")
    expect(page).to_not have_content(applicant_2.qualification)
  end

  it "lists matches as search results" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "In Progress")

    visit "/applicants/#{applicant_1.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Scooby"
    click_on("Search")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")

    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
  end

  it "Add a Pet to an Application" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets")

    visit "/applicants/#{applicant_1.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Scooby"
    click_on("Search")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")
    expect(page).to have_button("Adopt this Pet")

    click_on("Adopt this Pet")

    expect(current_path).to eq("/applicants/#{applicant_1.id}")
    expect(page).to have_content("#{pet_1.name}")
  end

  it "Submit an Application: update description and pending" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(name: "Dakota", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)
    app_2 = ApplicantPet.create!(applicant: applicant_1, pet: pet_2)

    visit "/applicants/#{applicant_1.id}"
    
    expect(page).to have_button("Submit Application")
    
    fill_in(:qualification, with: "I have land and need for more pets")
    click_button("Submit Application")
    
    expect(page).to have_content("Reason: I have land and need for more pets")
    expect(page).to have_content("App Status: Pending")
    expect(page).to_not have_content("In Progress")
    expect(page).to have_content("Scooby")
    expect(page).to have_content("Scrappy")
    expect(page).to_not have_content("Dakota")
  end

  it 'will NOT show submit application button if no pets are added to application' do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(name: "Dakota", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets")
    
    visit "/applicants/#{applicant_1.id}"
    
    expect(page).to_not have_button("Submit Application")
    expect(page).to have_content("I love pets")
    expect(page).to_not have_content("App Status: Pending")
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content("Scooby")
    expect(page).to_not have_content("Scrappy")
    expect(page).to_not have_content("Dakota")
  end

  it 'will show partial matches for pet names and case insensitive' do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(name: "Scrappy", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(name: "Dakota", age: 3, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets")
  
    visit "/applicants/#{applicant_1.id}"

    fill_in :search, with: "Scoo"
    click_on("Search")

    expect(page).to have_content("Scooby")

    fill_in :search, with: "dak"
    click_on("Search")

    expect(page).to have_content("Dakota")
  end
end