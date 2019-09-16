require "rails_helper"

RSpec.describe AnnualSchedule, type: :model do
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_uniqueness_of(:year) }
  it { is_expected.to validate_presence_of(:week_start_at) }
  it { is_expected.to validate_presence_of(:week_end_at) }

  describe "when a schedule for the current year is present" do
    let!(:schedule) do
      create(:annual_schedule,
        year: 2017,
        cfp_open_at: Date.parse("2017-03-19").freeze,
        cfp_close_at: Date.parse("2017-04-21").freeze,
        voting_open_at: Date.parse("2017-05-10").freeze,
        voting_close_at: Date.parse("2017-05-29").freeze,
        registration_open_at: Date.parse("2017-07-20").freeze,
        week_start_at: Date.parse("2017-09-25").freeze,
        week_end_at: Date.parse("2017-09-29").freeze,
        pitch_application_open_at: Date.parse("2017-08-08").freeze,
        pitch_application_close_at: Date.parse("2017-08-31").freeze,
        pitch_voting_open_at: Date.parse("2017-09-12").freeze,
        pitch_voting_close_at: Date.parse("2017-09-22").freeze,
        sponsorship_open_at: Date.parse("2017-03-01").freeze,
        sponsorship_close_at: Date.parse("2017-09-09").freeze,
        ambassador_application_open_at: Date.parse("2017-07-01").freeze,
        ambassador_application_close_at: Date.parse("2017-08-11").freeze)
    end

    describe "cfp_open?" do
      it "returns true when the current date is in the CFP period" do
        travel_to Date.parse("2017-04-01") do
          expect(AnnualSchedule.cfp_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the CFP period" do
        travel_to Date.parse("2017-04-25") do
          expect(AnnualSchedule.cfp_open?).to be_falsy
        end
      end

      it "returns false when the CFP open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:cfp_open_at).and_return(nil)
          expect(AnnualSchedule.cfp_open?).to be_falsy
        end
      end

      it "returns false when the CFP close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:cfp_close_at).and_return(nil)
          expect(AnnualSchedule.cfp_open?).to be_falsy
        end
      end
    end

    describe "voting_open?" do
      it "returns true when the current date is in the voting period" do
        travel_to Date.parse("2017-05-15") do
          expect(AnnualSchedule.voting_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the voting period" do
        travel_to Date.parse("2017-06-01") do
          expect(AnnualSchedule.voting_open?).to be_falsy
        end
      end

      it "returns false when the voting open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:voting_open_at).and_return(nil)
          expect(AnnualSchedule.voting_open?).to be_falsy
        end
      end

      it "returns false when the voting close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:voting_close_at).and_return(nil)
          expect(AnnualSchedule.voting_open?).to be_falsy
        end
      end
    end

    describe "registration_open?" do
      it "returns true when the current date is in the registration period" do
        travel_to Date.parse("2017-07-21") do
          expect(AnnualSchedule.registration_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the registration period" do
        travel_to Date.parse("2017-10-01") do
          expect(AnnualSchedule.registration_open?).to be_falsy
        end
      end

      it "returns false when the registration open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:registration_open_at).and_return(nil)
          expect(AnnualSchedule.registration_open?).to be_falsy
        end
      end
    end

    describe "pitch_application_open?" do
      it "returns true when the current date is in the pitch application period" do
        travel_to Date.parse("2017-08-10") do
          expect(AnnualSchedule.pitch_application_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the pitch application period" do
        travel_to Date.parse("2017-09-02") do
          expect(AnnualSchedule.pitch_application_open?).to be_falsy
        end
      end

      it "returns false when the pitch application open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:pitch_application_open_at).and_return(nil)
          expect(AnnualSchedule.pitch_application_open?).to be_falsy
        end
      end

      it "returns false when the pitch application close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:pitch_application_close_at).and_return(nil)
          expect(AnnualSchedule.pitch_application_open?).to be_falsy
        end
      end
    end

    describe "pitch_voting_open?" do
      it "returns true when the current date is in the pitch voting period" do
        travel_to Date.parse("2017-09-15") do
          expect(AnnualSchedule.pitch_voting_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the pitch voting period" do
        travel_to Date.parse("2017-09-24") do
          expect(AnnualSchedule.pitch_voting_open?).to be_falsy
        end
      end

      it "returns false when the pitch voting open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:pitch_voting_open_at).and_return(nil)
          expect(AnnualSchedule.pitch_voting_open?).to be_falsy
        end
      end

      it "returns false when the pitch voting close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:pitch_voting_close_at).and_return(nil)
          expect(AnnualSchedule.pitch_voting_open?).to be_falsy
        end
      end
    end

    describe "sponsorship_open?" do
      it "returns true when the current date is in the sponsorship period" do
        travel_to Date.parse("2017-04-01") do
          expect(AnnualSchedule.sponsorship_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the sponsorship voting period" do
        travel_to Date.parse("2017-09-24") do
          expect(AnnualSchedule.sponsorship_open?).to be_falsy
        end
      end

      it "returns false when the sponsorship open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:sponsorship_open_at).and_return(nil)
          expect(AnnualSchedule.sponsorship_open?).to be_falsy
        end
      end

      it "returns false when the sponsorship close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:sponsorship_close_at).and_return(nil)
          expect(AnnualSchedule.sponsorship_open?).to be_falsy
        end
      end
    end

    describe "ambassador_application_open?" do
      it "returns true when the current date is in the ambassador application period" do
        travel_to Date.parse("2017-08-01") do
          expect(AnnualSchedule.ambassador_application_open?).to be_truthy
        end
      end

      it "returns false when the current date is outside the ambassador application period" do
        travel_to Date.parse("2017-09-24") do
          expect(AnnualSchedule.ambassador_application_open?).to be_falsy
        end
      end

      it "returns false when the ambassador application open date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:ambassador_application_open_at).and_return(nil)
          expect(AnnualSchedule.ambassador_application_open?).to be_falsy
        end
      end

      it "returns false when the ambassador application close date is nil" do
        travel_to schedule.cfp_open_at.at_beginning_of_year do
          allow(schedule).to receive(:ambassador_application_close_at).and_return(nil)
          expect(AnnualSchedule.ambassador_application_open?).to be_falsy
        end
      end
    end

    describe "in_week?" do
      it "returns true when the current date is during the week" do
        travel_to Date.parse("2017-09-26") do
          expect(AnnualSchedule.in_week?).to be_truthy
        end
      end

      it "returns false when the current date is outside the week" do
        travel_to Date.parse("2017-10-01") do
          expect(AnnualSchedule.in_week?).to be_falsy
        end
      end
    end

    describe "post_week?" do
      it "returns true when the current date is after the week" do
        travel_to Date.parse("2017-10-01") do
          expect(AnnualSchedule.post_week?).to be_truthy
        end
      end

      it "returns false when the current date is before the week" do
        travel_to Date.parse("2017-09-01") do
          expect(AnnualSchedule.post_week?).to be_falsy
        end
      end
    end
  end
end
