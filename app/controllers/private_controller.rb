class PrivateController < ApplicationController
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = AuthorizeApiRequestService.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end