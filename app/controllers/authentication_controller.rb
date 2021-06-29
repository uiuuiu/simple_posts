class AuthenticationController < ApplicationController

  def authenticate
    service = AuthenticateUserService.call(params[:username], params[:password])
 
    if service.success?
      render json: { auth_token: service.result }
    else
      render json: { error: service.errors }, status: :unauthorized
    end
  end
 end