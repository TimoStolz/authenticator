# stolen and adabted from https://medium.com/@goncalvesjoao/rails-devise-jwt-and-the-forgotten-warden-67cfcf8a0b73
# see there for further details

module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        claims = parse_json_web_token
        return fail! unless claims
        return fail! unless claims.has_key?('sub')
        return fail! unless claims.has_key?('iat')

        if (user = User.find_by(id: claims['sub']))
          success! user
        else
          fail!
        end
      end

      protected

      def parse_json_web_token
        strategy, token = request.headers['Authorization'].split(' ')
        return nil if (strategy || '').downcase != 'bearer'
        return JWT.decode(token, Rails.application.secrets.secret_key_base).first
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        return nil
      end
    end
  end
end
