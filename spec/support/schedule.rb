RSpec.configure do |config|
  config.before(:example) do
    stub_schedule = build_stubbed(:annual_schedule)
    allow(AnnualSchedule).to receive(:current).and_return(stub_schedule)
    allow(AnnualSchedule).to receive(:find_by!).and_return(stub_schedule)
  end
end
