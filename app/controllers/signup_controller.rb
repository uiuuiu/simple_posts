class SignupController < ApplicationController

  def create
    service = RegisterAccountService.call(
        params[:username],
        params[:password],
        params[:password_confirmation]
    )

    if service.success?
      render json: { message: 'ok' }
    else
      render json: { error: service.errors }, status: :unprocessable_entity
    end
  end
end