class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      if auth.info.email
        user.email = auth.info.email
      else
        user.email = SecureRandom.hex + "@levifikri.com"
      end

      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      elsif data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      elsif data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = SecureRandom.hex + "@levifikri.com" if user.email.blank?
      end
    end
  end
end