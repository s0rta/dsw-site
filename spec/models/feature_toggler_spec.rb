require 'spec_helper'

describe FeatureToggler do

  before do
    FeatureToggler.clear
  end

  describe 'checking for the feedback feature' do
    it 'is inactive by default' do
      expect(FeatureToggler.feedback_active?).to be_falsy
    end

    it 'is active when it has been activated' do
      FeatureToggler.activate_feedback!
      expect(FeatureToggler.feedback_active?).to be_truthy
    end

    it 'is inactive when it has been deactivated' do
      FeatureToggler.activate_feedback!
      FeatureToggler.deactivate_feedback!
      expect(FeatureToggler.feedback_active?).to be_falsy
    end
  end

  describe 'checking for the submission feature' do
    it 'is inactive by default' do
      expect(FeatureToggler.submission_active?).to be_falsy
    end

    it 'is active when it has been activated' do
      FeatureToggler.activate_submission!
      expect(FeatureToggler.submission_active?).to be_truthy
    end

    it 'is inactive when it has been deactivated' do
      FeatureToggler.activate_submission!
      FeatureToggler.deactivate_submission!
      expect(FeatureToggler.submission_active?).to be_falsy
    end
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

end
