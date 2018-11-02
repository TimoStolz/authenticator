class Api::TokensController < ApiController
  before_action :authenticate_user!

  def create
    @token = current_user.tokens.create()
  end
end
