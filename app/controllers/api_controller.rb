class ApiController < ApplicationController
  include IsApi

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: { error: exception.message }, status: :forbidden }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

end
