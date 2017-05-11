require 'spec_helper'

describe FeatureToggler do

  before do
    FeatureToggler.clear
  end

  describe 'checking for the registration feature' do
    it 'is inactive by default' do
      expect(FeatureToggler.registration_active?).to be_falsy
    end

    it 'is active when it has been activated' do
      FeatureToggler.activate_registration!
      expect(FeatureToggler.registration_active?).to be_truthy
    end

    it 'is inactive when it has been deactivated' do
      FeatureToggler.activate_registration!
      FeatureToggler.deactivate_registration!
      expect(FeatureToggler.registration_active?).to be_falsy
    end
  end

  describe 'checking for the volunteership feature' do
    it 'is inactive by default' do
      expect(FeatureToggler.volunteership_active?).to be_falsy
    end

    it 'is active when it has been activated' do
      FeatureToggler.activate_volunteership!
      expect(FeatureToggler.volunteership_active?).to be_truthy
    end

    it 'is inactive when it has been deactivated' do
      FeatureToggler.activate_volunteership!
      FeatureToggler.deactivate_volunteership!
      expect(FeatureToggler.volunteership_active?).to be_falsy
    end
  end
end
