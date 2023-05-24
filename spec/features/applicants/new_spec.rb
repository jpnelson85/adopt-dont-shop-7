require "rails_helper"

RSpec.describe "Applicant New Page" do
  it "New application form page" do
    visit "/applicants/new"

    fill_in(:name, with: "Jim Smith")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "NV")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")

    click_button("Submit Application")
    
    expect(current_path).to eq("/applicants/#{Applicant.all.last.id}")
    expect(page).to have_content("Jim Smith")
    expect(page).to have_content("234 Meadows Lane")
    expect(page).to have_content("Lake City")
    expect(page).to have_content("NV")
    expect(page).to have_content("42894")
    expect(page).to have_content("Love All PETS!")
    expect(page).to have_content("In Progress")
  end

  it "validation for form page...name" do
    visit "/applicants/new"
    fill_in(:name, with: "")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")
    
    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end

  it "validation for form page...street address" do
    visit "/applicants/new"
    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")
    
    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end

  it "validation for form page...city" do
    visit "/applicants/new"
    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")
    
    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "46385")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end

  it "validation for form page...state" do
    visit "/applicants/new"
    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")
    
    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "45Janet")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")
    
    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end

  it "validation for form page...zip code" do
    visit "/applicants/new"
    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "")
    fill_in(:qualification, with: "Love All PETS!")

    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "Lake City City")
    fill_in(:qualification, with: "Love All PETS!")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "463")
    fill_in(:qualification, with: "Love All PETS!")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "463856598")
    fill_in(:qualification, with: "Love All PETS!")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end

  it "validation for form page...qualifications" do
    visit "/applicants/new"
    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "")
    
    click_button("Submit Application")

    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Please see examples and enter a valid response with no empty fields")
  end
end