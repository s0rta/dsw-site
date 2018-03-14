require 'rails_helper'

RSpec.describe Helpscout::Article, type: :model do

  describe 'attributes' do
    let(:article) { described_class.new('name' => 'Hello', 'text' => 'World') }

    it 'has a name' do
      expect(article.name).to eq('Hello')
    end

    it 'has content' do
      expect(article.content).to eq('World')
    end
  end

  describe 'fetching/caching from Helpscout', redis: true do
    it 'returns no articles when nothing is cached' do
      expect(described_class.all).to eq([])
    end

    it 'caches and returns fetched articles', vcr: true do
      described_class.fetch!
      expect(described_class.all.size).to eq(17)
      expect(described_class.all.first.name).to eq('Why do we need to vote on sessions?')
      expect(described_class.all.first.content).to eq(<<-HTML.strip)
        <p>The voting process makes Denver Startup Week a true community fueled event and encourages thousands of people to be a contributing part of building the week’s agenda. The community is encouraged to cast their votes for event and session ideas through July and organizers will announce the final events selected through the panel picker in mid-August. </p>
      HTML
    end
  end
end
