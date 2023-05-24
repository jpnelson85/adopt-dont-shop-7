require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  it "Approving a Pet for Adoption" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter_1.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "Pending")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)

    visit "/admin/applications/#{applicant_1.id}"

    within("#applicant-#{applicant_1.id}") do
    expect(page).to have_button("Approve Application")
    click_button("Approve Application")

    expect(current_path).to eq("/admin/applications/#{applicant_1.id}")
    expect(page).to_not have_button("Approve Application")
    expect(page).to have_content("Approved")
    end
  end

  it "Rejecting a Pet for Adoption" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter_1.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "Pending")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)

    visit "/admin/applications/#{applicant_1.id}"

    within("#applicant-#{applicant_1.id}") do
    expect(page).to have_button("Reject Application")
    click_button("Reject Application")

    expect(page).to_not have_button("Approve Application")
    expect(page).to_not have_button("Reject Application")
    expect(page).to have_content("Rejected")
    end
  end

  it "Approved/Rejected Pets on one Application do not affect other Applications" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter_1.id)
    applicant_1 = Applicant.create!(name: "Jimmy", street_address: "1234 road test", city: "Boca Raton", state: "FL", zip_code: "33498", qualification: "I love pets", application_status: "Pending")
    app_1 = ApplicantPet.create!(applicant: applicant_1, pet: pet_1)
    
    applicant_2 = Applicant.create!(name: "Jeff", street_address: "1234 Test test", city: "Springfield", state: "IN", zip_code: "12345", qualification: "Love Pets", application_status: "Pending")
    app_2 = ApplicantPet.create!(applicant: applicant_2, pet: pet_1)

    visit "/admin/applications/#{applicant_1.id}"

    within("#applicant-#{applicant_1.id}") do
    expect(page).to have_button("Reject Application")
    click_button("Reject Application")

    visit "/admin/applications/#{applicant_2.id}"

    expect(page).to have_button("Approve Application")
    expect(page).to have_button("Reject Application")
    end
  end
end