require 'active_support/concern'

module IsApi
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :null_session
    before_action :skip_session
    before_action :set_default_response_format

    public

    def skip_session
      request.session_options[:skip] = true
    end

    protected

    def default_response_format
      :json
    end

    def unspecified_format?
      request.format == "*/*" && params[:format].nil?
    end

    def set_default_response_format
      if unspecified_format?
        request.format = default_response_format
      end
    end
    
  end
end
