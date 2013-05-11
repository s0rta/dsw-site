require 'spec_helper'

describe NewsletterSignup do
  it 'subscribes via Mailchimp after creation' do
    ENV['NEWSLETTER_LIST_ID'] = '12345'
    Gibbon.any_instance.should_receive(:list_subscribe).with( id: '12345',
                                                             email_address: 'test@example.com',
                                                             merge_vars: {
                                                               FNAME: 'Test',
                                                               LNAME: 'User'
                                                             })
    NewsletterSignup.create! email:       'test@example.com',
                              first_name: 'Test',
                              last_name:  'User'
  end
end
