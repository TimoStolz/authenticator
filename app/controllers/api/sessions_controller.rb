class Api::SessionsController < Devise::SessionsController
  include IsApi
  respond_to :json
end
