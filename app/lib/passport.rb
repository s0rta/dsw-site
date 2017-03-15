module Inversoft
  class Auth

    def initialize
      @client = Inversoft::PassportClient.new('dsw-api-key', 'https://demo-passport.inversoft.io',
                                              ->(cr) { cr.success_response },
                                              ->(cr) { raise "Status = #{cr.status} error body = #{cr.error_response}" })
      @application_id = '5d972ce8-4a45-4b10-b444-4017b40f6cb2'
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