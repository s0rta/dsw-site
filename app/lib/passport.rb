module Inversoft
  class Auth

    def initialize
      @client = Inversoft::PassportClient.new('5918bf05-a35f-49e6-bb9d-3370340db7a2', 'https://dsw-passport.inversoft.io',
                                              ->(cr) { cr.success_response },
                                              ->(cr) { raise "Status = #{cr.status} error body = #{cr.error_response}" })
      @application_id = '62c7beed-9271-4850-a71a-ac3bca77bbfa'
    end

    def login(email, password)
      response = @client.login!({
          :loginId => email,
          :password => password,
          :applicationId => @application_id
      })
      user = response.user
      puts "logged in User [#{user.email}]"
    end

    def register(full_name, email, password)
      response = @client.register!(nil, {
          :user => {
              :fullName => full_name,
              :email => email,
              :password => password
          },
          :registration => {
              :applicationId => @application_id,
              :roles => %w(user)
          }
      })
      user = response.user
      puts "Registered User [#{user.email}]"
    end

    def forgot_password(email)
      @client.forgot_password!({
          :loginId => email
      })
      puts "Started Forgot Password Workflow, sending an email to [#{email}]"
    end

  end
end