# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomepageCta, type: :model do
  it { is_expected.to belong_to(:track).optional }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:subtitle) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:link_text) }
  it { is_expected.to validate_presence_of(:link_text) }
  it { is_expected.to validate_inclusion_of(:relevant_to_cycle).in_array(AnnualSchedule::CYCLES) }
  it { is_expected.to validate_numericality_of(:priority) }

  context 'Liquid syntax validation' do
    it { is_expected.to allow_value('{{ current_date }}').for(:title) }
    it { is_expected.not_to allow_value('{{ current_date').for(:title).with_message(:liquid_syntax) }
    it { is_expected.to allow_value('{{ current_date }}').for(:subtitle) }
    it { is_expected.not_to allow_value('{{ current_date').for(:subtitle).with_message(:liquid_syntax) }
    it { is_expected.to allow_value('{{ current_date }}').for(:body) }
    it { is_expected.not_to allow_value('{{ current_date').for(:body).with_message(:liquid_syntax) }
  end
end
