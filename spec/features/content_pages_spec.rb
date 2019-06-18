require "spec_helper"

feature "Content-only pages" do
  scenario "the sponsors page" do
    pending('refactor')
    visit "/"
    click_link "Sponsors"
    expect(page).to have_content("OUR #{Date.today.year} SPONSORS")
  end

  scenario "the basecamp page" do
    visit "/basecamp"
    expect(page).to have_content("BASECAMP LAUNCHED BY CHASE FOR BUSINESS")
  end

  scenario "the program page" do
    pending("refactor")
    visit "/program"
    expect(page).to have_content("Program")
  end

  scenario "the initiatives page" do
    visit "/initiatives"
    expect(page).to have_content("EXPANDING OUR MISSION")
  end

  describe "the get involved section" do
    scenario "the contact page" do
      visit "/get-involved"
      expect(page).to have_content("GET INVOLVED")
    end

    scenario "the FAQ page" do
      pending('refactor')
      allow(Helpscout::Article).to receive(:for_category)
        .and_return([Helpscout::Article.new("name" => "What is 2 + 2?", "text" => "4")])
      visit "/get-involved"
      click_link "FAQ"
      expect(page).to have_content("FREQUENTLY ASKED QUESTIONS")
      click_button "What is 2 + 2?"
      expect(page).to have_content("4")
    end

    scenario "the team page" do
      pending('refactor')
      visit "/get-involved"
      click_link "Team"
      expect(page).to have_content("TEAM")
    end

    scenario "the content page" do
      pending('refactor')
      visit "/get-involved"
      click_link "Content"
      expect(page).to have_content("SUBMIT & PROMOTE CONTENT")
    end
  end

  scenario "the assets page" do
    visit "/"
    click_link "Press"
    click_link "Assets"
    expect(page).to have_content("ASSETS")
  end

  scenario "the press page" do
    create(:newsroom_item, title: "Good news!", release_date: 1.day.ago, external_link: "http://www.google.com/")
    visit "/"
    click_link "Press"
    expect(page).to have_content("Good news!")
    click_link "Good news!"
    expect(current_url).to include("https://www.google.com/")
  end

  scenario "the code of conduct page" do
    visit "/"
    click_link "Code of Conduct"
    expect(page).to have_content("CODE OF CONDUCT")
  end

  scenario "the podcast page" do
    visit "/"
    click_link "Podcast"
    expect(page).to have_content("PODCAST")
  end
end
