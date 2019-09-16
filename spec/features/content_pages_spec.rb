require "spec_helper"

feature "Content-only pages" do
  scenario "the sponsors page" do
    visit "/"
    click_button "Open Main Menu"
    click_link "Sponsors"
    expect(page).to have_content("OUR #{Date.today.year} SPONSORS")
  end

  scenario "the program page" do
    visit "/"
    click_button "Open Main Menu"
    click_link "Program"
    expect(page).to have_content("ENTREPRENEURIAL SPIRIT")
  end

  describe "the get involved section" do
    scenario "the contact page" do
      visit "/"
      click_button "Open Main Menu"
      click_link "Get Involved"
      expect(page).to have_content("GET INVOLVED")
    end

    scenario "the FAQ page" do
      allow(Helpscout::Article).to receive(:for_category)
        .and_return([Helpscout::Article.new("name" => "What is 2 + 2?", "text" => "4")])
      visit "/"
      click_button "Open Main Menu"
      click_link "Get Involved"
      click_link "FAQ"
      expect(page).to have_content("FREQUENTLY ASKED QUESTIONS")
      click_button "What is 2 + 2?"
      expect(page).to have_content("4")
    end

    scenario "the team page" do
      visit "/"
      click_button "Open Main Menu"
      click_link "About"
      click_link "Team"
      expect(page).to have_content("TEAM")
    end
  end

  scenario "the assets page" do
    visit "/"
    click_button "Open Main Menu"
    click_link "About"
    click_link "Explore Assets"
    expect(page).to have_content("ASSETS")
  end

  scenario "the code of conduct page" do
    visit "/"
    click_link "Code of Conduct"
    expect(page).to have_content("CODE OF CONDUCT")
  end

  describe "inside the registration period" do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime + 1.day
    end

    after do
      travel_back
    end

    describe "browsing clusters" do
      let!(:cluster) { create(:cluster, name: "Business") }
      let!(:submission) do
        create(:submission,
          cluster: cluster,
          title: "Finance 101",
          state: "confirmed",
          start_day: 2,
          start_hour: 10,
          end_day: 2,
          end_hour: 11,
          year: AnnualSchedule.current.registration_open_at.year)
      end

      scenario "should be able to view a list of clusters and drill into detail pages" do
        visit "/"
        click_button "Open Main Menu"
        click_link "Program"
        click_link "Clusters"
        expect(page).to have_css(".ContentCard", text: "BUSINESS")
        click_link "Explore Business"
        click_link "View Business Sessions"
        expect(page).to have_css(".ScheduledSession", text: "Finance 101")
      end
    end

    describe "browsing tracks" do
      let!(:track) { create(:track, name: "Business") }
      let!(:submission) do
        create(:submission,
          track: track,
          title: "Finance 101",
          state: "confirmed",
          start_day: 2,
          start_hour: 10,
          end_day: 2,
          end_hour: 11,
          year: AnnualSchedule.current.registration_open_at.year)
      end

      scenario "should be able to view a list of tracks and drill into detail pages" do
        visit "/"
        click_button "Open Main Menu"
        click_link "Program"
        click_link "Tracks"
        expect(page).to have_css(".ContentCard", text: "BUSINESS")
        click_link "Explore Business"
        click_link "View Business Sessions"
        expect(page).to have_css(".ScheduledSession", text: "Finance 101")
      end
    end
  end
end
