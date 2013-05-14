class User < ActiveRecord::Base
  attr_accessible :email, :linkedin_uid, :name, :description

  has_many :submissions, foreign_key: 'submitter_id'

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.where(linkedin_uid: auth_hash[:uid]).first_or_initialize
    user.update_attributes  linkedin_uid: auth_hash[:uid],
                            name:         auth_hash[:info][:name],
                            email:        auth_hash[:info][:email],
                            description:  auth_hash[:info][:description]
    user
  end

end