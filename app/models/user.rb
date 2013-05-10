class User < ActiveRecord::Base
  attr_accessible :email, :linkedin_uid, :name, :description

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_or_initialize_by_linkedin_uid(auth_hash[:uid])
    user.update_attributes  linkedin_uid: auth_hash[:uid],
                            name:         auth_hash[:info][:name],
                            email:        auth_hash[:info][:email],
                            description:  auth_hash[:info][:description]
    user
  end

end
