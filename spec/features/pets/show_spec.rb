require "rails_helper"

RSpec.describe "the shelter show" do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    shelter2 = Shelter.create(name: "Main House", city: "Boston", foster_program: false, rank: 9)
    pet2 = Pet.create(name: "Hawk", age: 5, breed: "Corgi", adoptable: true, shelter_id: shelter2.id)
    
    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.shelter_name)
    expect(page).to_not have_content(pet2.name)
    expect(page).to_not have_content(pet2.age)
    expect(page).to_not have_content(pet2.breed)
    expect(page).to_not have_content(pet2.shelter_name)
  end

  it "allows the user to delete a pet" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    pet = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    click_on("Delete #{pet.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet.name)
  end
end
