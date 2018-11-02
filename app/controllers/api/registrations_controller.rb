class Api::RegistrationsController < Devise::RegistrationsController
  include IsApi
  respond_to :json
end
