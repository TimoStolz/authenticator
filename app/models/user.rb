require 'jwt'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  attr_accessor :login

  def login
    @login || username || email
  end

  def generate_jwt
    return JWT.encode(
      {
        sub: id,
        iat: DateTime.now.to_i,
        exp: 14.days.from_now.to_i
      },
      Rails.application.secrets.secret_key_base,
      'HS256'
    )
  end

  def self.find_for_database_authentication(warden_conditions)
    # tutorial for logins with username or email
    # https://github.com/plataformatec/devise/wiki/how-to:-allow-users-to-sign-in-using-their-username-or-email-address
    conditions = warden_conditions.dup
    conditions[:email]&.downcase!
    conditions[:username]&.downcase!
    conditions[:login]&.downcase!

    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
