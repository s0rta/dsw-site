RSpec.configure do |config|
  config.before(:example) do
    allow(AnnualSchedule).to receive(:current).and_return(build_stubbed(:annual_schedule))
  end
end
