# -*- encoding : utf-8 -*-
class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def gravatar_url(size = 34, default = "identicon")
    digest = Digest::MD5.hexdigest(self.email.downcase)
    "http://www.gravatar.com/avatar/#{digest}?s=#{size}&d=#{default}"
  end

end
